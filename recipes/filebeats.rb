#
# Cookbook Name:: myapp
# Recipe:: site
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

## sudo chef-client -z -o myapp::site | name of recipe

# myapp_plurk 'site1' do
# 	title 'hi'
# 	racun 'idem'
# end

# myapp_plurk 'site2' do
# 	title 'hi from site 2'
# 	racun 'makan steak'
# end

library_filebeats "node['service_name']" do
	#app node['service_name']
	log_file node['log_file']
	#log_type "#{node['service_name']}_log"
	logstash_server_url node['logstash_server_url']
	port node['logstash']['port']
end