
#jmatt
CREATE ROLE jmatt PASSWORD 'atmosphere' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;

GRANT ALL PRIVILEGES ON DATABASE atmosphere TO esteve;

GRANT ALL ON TABLE cloudauth_configs to jmatt;
GRANT ALL ON TABLE cloudauth_tokens to jmatt;

GRANT ALL ON TABLE cloudfront_access_logs to jmatt;
GRANT ALL ON TABLE cloudfront_configs to jmatt;
GRANT ALL ON TABLE cloudfront_tokens to jmatt;

GRANT ALL ON TABLE cloudservice_api_logs to jmatt;
GRANT ALL ON TABLE cloudservice_applications to jmatt;
GRANT ALL ON TABLE cloudservice_configs to jmatt;
GRANT ALL ON TABLE cloudservice_ec2_keys to jmatt;
GRANT ALL ON TABLE cloudservice_instance_launch_hooks to jmatt;
GRANT ALL ON TABLE cloudservice_instances to jmatt;
GRANT ALL ON TABLE cloudservice_machine_image_userdata_scripts to jmatt;
GRANT ALL ON TABLE cloudservice_machine_images to jmatt;
GRANT ALL ON TABLE cloudservice_machine_volumes to jmatt;
GRANT ALL ON TABLE cloudservice_user_applications to jmatt;
GRANT ALL ON TABLE cloudservice_user_resource_quotas to jmatt;

GRANT ALL ON TABLE django_session to jmatt;

#esteve
CREATE ROLE esteve PASSWORD 'atmosphere' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;

GRANT ALL PRIVILEGES ON DATABASE atmosphere TO esteve;

GRANT ALL ON TABLE cloudauth_configs to esteve;
GRANT ALL ON TABLE cloudauth_tokens to esteve;

GRANT ALL ON TABLE cloudfront_access_logs to esteve;
GRANT ALL ON TABLE cloudfront_configs to esteve;
GRANT ALL ON TABLE cloudfront_tokens to esteve;

GRANT ALL ON TABLE cloudservice_api_logs to esteve;
GRANT ALL ON TABLE cloudservice_applications to esteve;
GRANT ALL ON TABLE cloudservice_configs to esteve;
GRANT ALL ON TABLE cloudservice_ec2_keys to esteve;
GRANT ALL ON TABLE cloudservice_instance_launch_hooks to esteve;
GRANT ALL ON TABLE cloudservice_instances to esteve;
GRANT ALL ON TABLE cloudservice_machine_image_userdata_scripts to esteve;
GRANT ALL ON TABLE cloudservice_machine_images to esteve;
GRANT ALL ON TABLE cloudservice_machine_volumes to esteve;
GRANT ALL ON TABLE cloudservice_user_applications to esteve;
GRANT ALL ON TABLE cloudservice_user_resource_quotas to esteve;

GRANT ALL ON TABLE django_session to esteve;
