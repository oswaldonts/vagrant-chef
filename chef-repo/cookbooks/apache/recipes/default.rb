# apt_update 'Update the apt cache daily' do
#   frequency 86400
#   action :periodic
# end

package "apache2"

service "apache2" do
  supports :status => true
  action :nothing
end

template "apache2.conf" do
  path "/etc/apache2/apache2.conf"
  source "apache2.conf.erb"
end

file "remove_default_conf" do
  path "/etc/apache2/sites-enabled/000-default.conf"
  action :delete
end

template "wordpress.conf" do
  path  "/etc/apache2/sites-available/wordpress.conf"
  source "wordpress.conf.erb"
end

link "link_wordpress_conf" do
  target_file "/etc/apache2/sites-enabled/wordpress.conf"  
  to "/etc/apache2/sites-available/wordpress.conf"
  notifies :restart, 'service[apache2]', :immediately
end

# cooobook_file => transfer files. 
# "#{node['apache']['document_root']}/index.html"  is path to the file to be created
# source 'index.html' significa que dentro de la carpeta "files" busque "index.html"
# cookbook_file "#{node['apache']['document_root']}/index.html" do
#   path "#{node['apache']['document_root']}/index.html"
#   source 'index.html'
#   only_if do
#     File.exist?('/etc/apache2/sites-enabled/vagrant.conf')
#   end
# end

# include_recipe '::facts'

  