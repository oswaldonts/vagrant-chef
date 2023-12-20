package "php"

package "php_modules" do
    package_name ["libapache2-mod-php", "php-mysql", "php-curl", "php-gd", "php-xml", "php-mbstring", "php-xmlrpc", "php-zip", "php-soap", "php-intl"]
    action :install
end