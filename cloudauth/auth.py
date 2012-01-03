#
# The contents of this file are subject to the terms listed in the LICENSE file you received with this code.
#
# Project: Atmosphere, iPlant Collaborative
# Author: Seung-jin Kim
# Twitter: @seungjin
# GitHub: seungjin
#

from django.http import HttpResponse
from atmosphere.cloudauth.models import *

import uuid
import logging
import datetime
from datetime import timedelta

import sys
import ldap

def ldap_validate(username,password):
    server_obj = Configs.objects.filter(key='ldap_server').order_by('value')[0]
    server = server_obj.value
    conn = ldap.initialize(server)
    ldap_server_dn_obj = Configs.objects.filter(key='ldap_server_dn').order_by('value')[0]
    ldap_server_dn_value = ldap_server_dn_obj.value    
    dn = "uid="+username+","+ldap_server_dn_value
    try :
        auth = conn.simple_bind_s(dn,password)
        return True
    except :
        return False

"""
   searchLDAP: search LDAP using searchFilter criteria, 
   result_set: list of attributes for each user found
"""
def searchLDAP(LDAP_HOST, LDAP_BASEDN, searchFilter, retrieveAttr) :
        try:
                l = ldap.open(LDAP_HOST)
                ldap_result_id = l.search(LDAP_BASEDN, ldap.SCOPE_SUBTREE, searchFilter, retrieveAttr)
                result_set = []
                while 1:
                        result_type, result_data = l.result(ldap_result_id, 0)
                        if(result_data == []):
                                break
                        else:
                                if result_type == ldap.RES_SEARCH_ENTRY:
                                        result_set.append(result_data)
                return result_set
        except ldap.LDAPError, e:
                print e
"""
    groupSearch: Return all groups who match the 'search_filter' criteria
    return: List of groups matching 'search_filter'
"""
def groupSearch(search_filter):
        attrs = ['cn']
        result = searchLDAP(ldap_host, 'ou=Groups,dc=iplantcollaborative,dc=org', search_filter, attrs)
        mygroups = []
        if result != []:
                for res in result:
                        mygroups.append(res[0][1]['cn'][0])
                return mygroups
        else:
                return None

def auth(request):
    if request.META.has_key('HTTP_X_AUTH_KEY') and request.META.has_key('HTTP_X_AUTH_USER') :
        x_auth_user = request.META['HTTP_X_AUTH_USER']
        x_auth_key = request.META['HTTP_X_AUTH_KEY']
        
        if ldap_validate(x_auth_user,x_auth_key) == True :
            # User has validated. If this is an administrator who would like to emulate a user
            groups = groupSearch("memberUid=%s" % x_auth_user)
            if 'core-services' in groups and request.META.has_key('HTTP_X_EMULATE_USER') :
		# Replace the old username with the emulated username
		request.META['HTTP_X_AUTH_USER'] = request.META['HTTP_X_EMULATE_USER']
            return auth_response(request)
        else :
            return HttpResponse("401 UNAUTHORIZED", status=401)
    else :
        return HttpResponse("401 UNAUTHORIZED", status=401)

def auth_response(request):
  
  api_server_url = Configs.objects.filter(key='api_server_url').order_by('value')[0]
  
  #login validation
  #return HttpResponse("hello",mimetype="text/plain" )
  response = HttpResponse()
  
  response['Access-Control-Allow-Origin'] = '*'
  response['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
  response['Access-Control-Max-Age'] = 1000
  response['Access-Control-Allow-Headers'] = '*'
  
  #response.write("heelo it is me")
  response['X-Server-Management-Url'] = api_server_url.value
  response['X-Storage-Url'] = "http://"
  response['X-CDN-Management-Url'] = "http://"
  token = str(uuid.uuid4())
  response['X-Auth-Token'] = token
  #print request
  auth_user_token = Tokens(user=request.META['HTTP_X_AUTH_USER'],token=token,issuedTime=datetime.datetime.now(),remote_ip=request.META['REMOTE_ADDR'],api_server_url=api_server_url.value)
  auth_user_token.save()
  return response

def auth_emulate(request):
    if request.META.has_key('HTTP_X_AUTH_KEY') and request.META.has_key('HTTP_X_AUTH_USER') :
        x_auth_user = request.META['HTTP_X_AUTH_USER']
        x_auth_key = request.META['HTTP_X_AUTH_KEY']
        
        if ldap_validate(x_auth_user,x_auth_key) == True :
            #IF user is ADMINISTRATOR ONLY == True:
            return auth_emulate_response(request)
        else :
            return HttpResponse("401 UNAUTHORIZED", status=401)
    else :
        return HttpResponse("401 UNAUTHORIZED", status=401)

def auth_emulate_response(request):
  api_server_url = Configs.object.filter(key='api_server_url').order_by('value')[0]

  response = HttpResponse()
  response['Access-Control-Allow-Origin'] = '*'
  response['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
  response['Access-Control-Max-Age'] = 1000
  response['Access-Control-Allow-Headers'] = '*'

  response['X-Server-Management-Url'] = api_server_url.value
  response['X-Storage-Url'] = "http://"
  response['X-CDN-Management-Url'] = "http://"
  token = str(uuid.uuid4())
  response['X-Auth-Token'] = token
  #Determine the emulated user
  auth_user_token = Tokens(user=request.META['HTTP_X_EMULATED_USER'],token=token,issuedTime=datetime.datetime.now(),remote_ip=request.META['REMOTE_ADDR'],api_server_url=api_server_url.value)
  auth_user_token.save()
  return response


def validate_token(request):
    if request.META.has_key('HTTP_X_AUTH_USER') and request.META.has_key('HTTP_X_AUTH_TOKEN') :
        user = request.META['HTTP_X_AUTH_USER']
        token = request.META['HTTP_X_AUTH_TOKEN']
        api_server = request.META['HTTP_X_AUTH_API_SERVER']
        
        try :
            token = Tokens.objects.get(token=token)
        except Tokens.DoesNotExist:
            return HttpResponse("401 UNAUTHORIZED", status=401)
        
        d = timedelta(days=1)
        
        if token.user == user and token.logout == None and ( token.issuedTime + d > datetime.datetime.now() ) and token.api_server_url == api_server :
            return HttpResponse("Valid token")
        else:
            return HttpResponse("401 UNAUTHORIZED", status=401)
    else :
        return HttpResponse("401 UNAUTHORIZED", status=401)
