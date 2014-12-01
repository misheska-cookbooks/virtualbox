dmg_url = mac_download_url
dmg_sha256 = vbox_sha256sum(dmg_url)

dmg_package 'VirtualBox' do
  source dmg_url
  checksum dmg_sha256
  type 'pkg'
end
