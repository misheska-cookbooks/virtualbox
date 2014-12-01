#
# Cookbook Name:: virtualbox
# Recipe:: default
#

case node['platform_family']
when 'mac_os_x'
  include_recipe 'virtualbox::_install_mac_osx'
end
