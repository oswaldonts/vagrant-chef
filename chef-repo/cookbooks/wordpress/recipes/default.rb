execute "wp_cli" do
    command <<-EOH
        cd /opt;
        curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
        chmod +x wp-cli.phar && sudo cp wp-cli.phar /usr/local/bin/wp;
    EOH
    not_if "test -f /opt/wp-cli.phar"
end


execute "wp_install" do
    command <<-EOH
        wp core download --path=#{node['apache']['wp_location']} --allow-root;
        cd /var/www/wordpress;
        wp core config --dbname=#{node['mysql']['wp_db_name']} --dbuser=#{node['mysql']['wp_db_user']} --dbpass=#{node['mysql']['wp_db_password']} --dbhost=localhost --dbprefix=wp_ --allow-root;
        wp core install --url=#{node['apache']['vm_ip']} --title="#{node['wordpress']['wp_site_title']}" --admin_user=#{node['wordpress']['wp_admin_user']} --admin_password=#{node['wordpress']['wp_admin_password']} --admin_email=#{node['wordpress']['wp_admin_email']} --allow-root;
        wp post create --post_author=1 --post_type=post --post_title="#{node['wordpress']['wp_post_title']}" --post_content="#{node['wordpress']['wp_post_content']}" --post_status=publish --allow-root;
    EOH
    not_if "test -f #{node['apache']['wp_location']}/index.php"
    notifies :restart, 'service[apache2]', :immediately
end
