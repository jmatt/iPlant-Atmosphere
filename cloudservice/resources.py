# -*- coding: utf-8 -*- 
#
# The contents of this file are subject to the terms listed in the LICENSE file you received with this code.
#
# Project: Atmosphere, iPlant Collaborative
# Author: Seung-jin Kim
# Twitter: @seungjin
# GitHub: seungjin
#

from django.http import HttpResponse
from django.template import Context
from django.template.loader import get_template

from django.http import HttpResponse, Http404
from django.contrib.auth.models import User

from django.http import HttpResponseRedirect
from django.contrib.auth import logout

from django.http import HttpResponseNotFound
from django.http import HttpResponseForbidden

from django.utils import simplejson
import logging
#from library.cloud import Cloud
from atmosphere.cloudservice.models import *

import uuid

def request(request) :
	method = request.META['PATH_INFO'].split('/')[2];
	logging.debug('METHOD REQUESTED: ' + method)
	#return HttpResponse(getInstanceList())
	if len(method) > 0 :
		try :
			c = Cloud(ec2_access_key=Ec2_keys.objects.get(username=request.user.username).ec2_access_key,ec2_secret_key=Ec2_keys.objects.get(username=request.user.username).ec2_secret_key)
			f=getattr(c,method)
			return HttpResponse(f(request))
		except Exception, e:
			logging.error("cloudservice.library.cloud error: %s" % e)
			print "cloudservice.library.cloud error: %s" % e
			return HttpResponseNotFound('<h1>HTTP/1.0 404 METHOD NOT FOUND</h1>')
	else :
		logging.error("cloudservice.library.cloud error: method [%s]" % method)
		return HttpResponseNotFound('<h1>HTTP/1.0 404 METHOD NOT FOUND</h1>')

def create_resource_id(resource_type):
	resource_id = str(uuid.uuid4())
	resource_index = Resource_indexes(resource_id = resource_id, resource_type = resource_type )
	resource_index.save()
	return str(uuid.uuid4())