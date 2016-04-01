property :site_name, String, name_property: true
property :title, String
property :racun, String

action :start do
    directory "/var/www/#{site_name}" do
        mode 0644
        user 'log'
        group 'wheel'
    end

    # file "/var/www/#{site_name}/index.html" do
    #   action :delete
    # end


    file "/var/www/#{site_name}/index.html" do
        content "<title>#{title}</title></br><body>#{racun}</body>"
        mode 0644
        user 'log'
        group 'wheel'
        notifies :restart, 'service[httpd]'
    end

    service 'httpd' do
        action :nothing
    end
end