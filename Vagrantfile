Vagrant.configure("2") do |config|
  
  $servers = [
    { hostname: 'ansible', ip: '192.168.20.101', ports: [[2201, 22]], os: "geerlingguy/centos7", scripts: ['ansible'] },
    { hostname: 'server1', ip: '192.168.20.102', ports: [[2202, 22]], os: "geerlingguy/centos7", cpu: 1, memory: 512, scripts: ['server'] },
    { hostname: 'server2', ip: '192.168.20.103', ports: [[2203, 22]], os: "geerlingguy/centos7", cpu: 1, memory: 512, scripts: ['server'] },
    { hostname: 'ntp1',    ip: '192.168.20.104', ports: [[2204, 22]], os: "geerlingguy/centos7", cpu: 1, memory: 512, scripts: ['server'] },
    { hostname: 'ntp2',    ip: '192.168.20.105', ports: [[2205, 22]], os: "geerlingguy/centos7", cpu: 1, memory: 512, scripts: ['server'] },
    { hostname: 'pki1',    ip: '192.168.20.106', ports: [[2206, 22]], os: "geerlingguy/centos7", cpu: 1, memory: 512, scripts: ['server'] },
    { hostname: 'rundeck', ip: '192.168.20.107', ports: [[2207, 22], [4440, 4440]], os: "geerlingguy/centos7", cpu: 4, memory: 2048, scripts: ['server'] },
  ]

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 2
    vb.linked_clone = true
    vb.customize ["modifyvm", :id, "--defaultfrontend", "headless"]
    vb.customize ["modifyvm", :id, "--audio", "none"]
    vb.customize ["modifyvm", :id, "--vram", "9"]
    # vb.customize ["setextradata", :id, "GUI/ScaleFactor", "2"] # This is useful on high-DPI monitors
  end

  $servers.each do |s|
    config.vm.define s[:hostname], autostart: false do |srv|
      srv.vm.box = s[:os]
      srv.vm.hostname = s[:hostname]
      srv.vm.network "private_network", virtualbox__intnet: "ansiblenet", ip: s[:ip]
      srv.vm.network "forwarded_port", host: 2222, guest: 22, id: "ssh", disabled: true
      srv.vm.synced_folder ".", "/vagrant", type: "virtualbox"

      config.vm.provider "virtualbox" do |vb|
        if s.key?(:cpu)
          vb.cpus = s[:cpu]
        end
        if s.key?(:memory)
          vb.memory = s[:memory]
        end
      end

      if s.key?(:ports)
        s[:ports].each do |port|
          srv.vm.network "forwarded_port", host: port[0], guest: port[1]
        end
      end

      srv.vm.provider "virtualbox" do |vb|
        vb.name = "#{s[:hostname]}"
      end

      if s.key?(:scripts)
        s[:scripts].each do |script|
          srv.vm.provision :shell, path: "build_scripts/#{script}.sh"
        end
      end
    end
  end
end
