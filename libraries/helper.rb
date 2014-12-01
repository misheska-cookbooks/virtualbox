require 'uri'
require 'open-uri'

module Vbox
  # Helper methods for working with VirtualBox
  module Helper
    def latest_version
      virtualbox_latest_url = \
        'http://download.virtualbox.org/virtualbox/LATEST.TXT'
      uri_parsed = URI.parse(virtualbox_latest_url)
      Net::HTTP.get(uri_parsed).strip!
    end

    def mac_filename(version)
      virtualbox_latest_sha256sums_url = \
        "http://download.virtualbox.org/virtualbox/#{version}/SHA256SUMS"
      filename = ''
      open(virtualbox_latest_sha256sums_url).each do |line|
        filename = line.split(' *')[1] if line =~ /OSX\.dmg/
      end
      filename.strip!
    end

    def mac_url(version)
      download_base_url = 'http://download.virtualbox.org/virtualbox'
      "#{download_base_url}/#{version}/#{mac_filename(version)}"
    end

    def local_path_from_url(url)
      package_name = package_name_from_url(url)
      File.join(Chef::Config[:file_cache_path], package_name)
    end

    def package_name_from_url(url)
      ::File.basename(url)
    end

    def vbox_sha256sum(url)
      filename = ::File.basename(::URI.parse(url).path)
      urlbase = url.gsub(filename, '')
      sha256sum = ''
      open("#{urlbase}/SHA256SUMS").each do |line|
        sha256sum = line.split(' ')[0] if line =~ /#{filename}/
      end
      sha256sum
    end

    def download_version
      return latest_version if node['virtualbox']['version'] == 'latest'

      node['virtualbox']['version']
    end

    def mac_download_url
      if node['virtualbox']['url'].nil? || node['virtualbox']['url'].empty?
        return mac_url(download_version)
      end

      node['virtualbox']['url']
    end
  end
end

Chef::Recipe.send(:include, Vbox::Helper)
