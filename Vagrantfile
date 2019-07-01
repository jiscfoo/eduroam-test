Vagrant.configure("2") do |config|

  config.vm.box = "generic/alpine310"

  config.vm.provider "virtualbox" do |v|
    v.default_nic_type = "virtio"
    v.customize ["modifyvm", :id, "--audio", "none"]
  end
  config.vm.provision "shell", inline: <<-SHELL
    apk add nmap vim bash
  SHELL
end

