package "mysql" do
    package_name "mysql-server"
    action :install
end

template "copy_sql_script" do
    path "/home/vagrant/script.sql"
    source "script.sql.erb"
end

execute "wp_db_installation" do
    command "sudo mysql --execute \"source /home/vagrant/script.sql;\""
    only_if "sudo mysql"
end
