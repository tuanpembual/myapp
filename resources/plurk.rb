property :site_name, String, name_property: true
property :title, String
property :racun, String

action :start do

    directory "/var/www/" do
      mode 0755
      owner 'vagrant'
      group 'vagrant'
      action :create
    end


    directory "/var/www/#{site_name}" do
        mode 0644
        user 'vagrant'
        group 'vagrant'
    end

    # file "/var/www/#{site_name}/index.html" do
    #   action :delete
    # end


    file "/var/www/#{site_name}/index.html" do
        content "<title>#{title}</title></br><body>#{racun}</body>"
        mode 0644
        user 'vagrant'
        group 'vagrant'
        notifies :restart, 'service[nginx]'
    end

    service 'nginx' do
        action :nothing
    end
end