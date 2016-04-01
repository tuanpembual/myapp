#
# Cookbook Name:: myapp
# Recipe:: site
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

## sudo chef-client -z -o myapp::site | name of recipe

myapp_plurk 'site1' do
	title 'hi'
	racun 'idem'
end

myapp_plurk 'site2' do
	title 'hi from site 2'
	racun 'makan steak'
end