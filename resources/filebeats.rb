property :service_name, String, required: true, name_property: true
property :logstash_server_url, String, required: true
property :port, Fixnum, required: true
property :log_file,String, required: true

action :create do

  package "apt-transport-https"

  apt_repository 'filebeats' do
    uri          'https://packages.elastic.co/beats/apt'
    arch         'amd64'
    distribution 'stable'
    components   ['main']
    key          'https://packages.elastic.co/GPG-KEY-elasticsearch'
  end

  package "filebeat"


  directory "/etc/pki/tls/certs" do
    mode 00744
    action :create
    recursive true
  end

  directory "/var/log/filebeat" do
    mode 00744
    action :create
    recursive true
  end

  cookbook_file "logstash-forwarder.crt" do
    source "logstash_forwarder/logstash-forwarder.crt"
    path "/etc/pki/tls/certs/logstash-forwarder.crt"
    mode "644"
    cookbook "myapp"
    action :create
  end

  template "/etc/filebeat/filebeat.yml" do
    source "logstash/filebeat.yml.erb"
    mode "644"
    cookbook "myapp"
    variables(app:      service_name,
              log_file: log_file,
              log_type: "#{service_name}.log",
              local_ip: node.ipaddress,
              environment: node.chef_environment,
              logstash_server_url: logstash_server_url,
              port: node[:logstash][:port]
             )
    notifies :restart, "service[filebeat]", :delayed
  end

  service "filebeat" do
    action :enable
    supports :status => true, :start => true, :stop => true, :restart => true
  end

end
