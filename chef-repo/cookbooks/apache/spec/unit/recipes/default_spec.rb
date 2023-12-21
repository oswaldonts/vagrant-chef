#
# Spec:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

require 'chefspec'

# Cookbook:: apache
describe 'apache::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version:'20.04').converge(described_recipe) }

  context 'with default recipe' do
    #validación de paquetes necesarios para Wordpress
    it 'installs necessary packages' do
      expect(chef_run).to install_package('apache2')
    end

    #validación del estado del servicio
    it 'has service enabled' do
      expect(chef_run).to enable_service('apache2')
    end

#    #valida creación de archivo de configuración
#    it 'creates configuration files' do
#     expect(chef_run).to create_template('/etc/apache2/apache2.conf')
#    end
  end
end


# Cookbook:: php
describe 'php::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version:'20.04').converge(described_recipe) }

  context 'with default recipe' do
    #validación de paquetes necesarios para Wordpress
    it 'installs necessary packages' do
      expect(chef_run).to install_package('php')
    end

    it 'creates configuration files' do
      expect(chef_run).to create_template('/etc/php/php.ini')
    end
  end
end

# Cookbook:: mysql
describe 'mysql::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version:'20.04').converge(described_recipe) }

  context 'with default recipe' do
    it 'has wordpress db name equals to wpdb' do
      expect(chef_run.node['mysql']['wp_db_name']).to eq('wpdb')
    end

    it 'has wordpress db user name equals to wpuser' do
      expect(chef_run.node['mysql']['wp_db_user']).to eq('wpuser')
    end
  end
end


# describe 'vim_pruebas_chef::default' do
#   platform 'ubuntu'
#
#   context 'with default attributes' do
#     it "should have default install_method 'package'" do
#       expect(chef_run.node['vim']['install_method']).to eq('package-fake')
#     end
#
#     it "should include the vim_pruebas_chef::package recipe when install_method='package'" do
#       expect(chef_run).to include_recipe('vim_pruebas_chef::package')
#     end
#   end
#
#   context "with 'source' as install_method" do
#
#     override_attributes['vim']['install_method'] = 'source'
#
#     it "should include the vim_pruebas_chef::source recipe when install_method='source'" do
#       expect(chef_run).to include_recipe('vim_pruebas_chef::source')
#     end
#   end
# end
