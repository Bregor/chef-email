#
# Cookbook Name:: email
# Recipe:: default
#
# Copyright 2014, Maxim Filatov
#
# MIT Licence
#

include_recipe 'email::opendkim' if node[:email][:dkim]
include_recipe 'email::postfix'
