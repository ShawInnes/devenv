# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "win10"
  config.vm.box_check_update = false
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "public_network"

  config.vm.synced_folder "/Users/shaw.innes/devops", "/jobs"

  config.vm.provider "vmware_fusion" do |v|
    v.gui = true
    v.linked_clone = true
    v.vmx["memsize"] = "8192"
    v.vmx["numvcpus"] = "4"
  end

  config.vm.provision 'bootstrap', type: 'shell', path: "scripts/bootstrap.cmd"

  config.vm.provision 'install tools', type: 'shell', inline: <<-SHELL
    chocolatey feature enable -n=allowGlobalConfirmation
    choco install GoogleChrome
    choco install git.install
    choco install dotnetcore-sdk
    choco install visualstudio2019enterprise
    choco install visualstudio2019-workload-netcoretools
    choco install visualstudio2019-workload-netweb
  SHELL
end
