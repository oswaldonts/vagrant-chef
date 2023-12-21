#
# Spec:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

require 'chefspec'

# Cookbook:: apache
describe 'apache::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version:'20.04').converge(described_recipe) }

  #validación de paquetes necesarios para Wordpress
  it 'installs necessary packages' do
    expect(chef_run).to install_package('apache2')
  end
  
  #validación del estado del servicio
  it 'service status' do
    expect(chef_run).to enable_service('apache2')
	expect(chef_run).to start_service('apache2')
  end
  
  #valida creación de archivo de configuración
   it 'creates configuration files' do
  expect(chef_run).to create_template('/etc/apache2/apache2.conf')
 end
  

end


# Cookbook:: php
describe 'php::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version:'20.04').converge(described_recipe) } 

#validación de paquetes necesarios para Wordpress
  it 'installs necessary packages' do
    expect(chef_run).to install_package('php')
  end
  
 it 'creates configuration files' do
  expect(chef_run).to create_template('/etc/php/php.ini')
 end
  

end


