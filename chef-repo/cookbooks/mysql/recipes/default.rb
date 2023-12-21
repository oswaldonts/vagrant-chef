package "mysql" do
    package_name "mysql-server"
    action :install
end

template "copy_sql_script" do
    path "/opt/script.sql"
    source "script.sql.erb"
end

execute "wp_db_installation" do
    command "sudo mysql --execute \"source /opt/script.sql;\""
    only_if "sudo mysql"
end
