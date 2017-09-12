require 'spec_helper'
 
describe 'libreswan_config', :type => 'class' do

ipsec_config = {
    'dumpdir' => '/var/run/pluto/',
    'nat_traversal' => 'no',
    'oe' => 'off',
    'protostack' => 'netkey',
    'force_keepalive' => 'yes',
    'config_keep_alive' => '60',
}

secrets = {
    'test-secret' => {
        'ensure' => 'present',
        'id'     => '192.168.55.1 192.168.56.1',
        'type'   => 'PSK',
        'secret' => 'super-secret',
    }
}

connections = {
    'test-connection' => {
          'ensure' => 'present',
          'options'   => {
              'authby' => 'secret',
              'pfs'  => 'yes',
              'auto' => 'start',
              'left' => '192.168.55.1',
              'leftsourceip' => '192.168.55.1',
              'leftsubnet' => '192.168.55.0/24',
              'right' => '192.168.56.1',
              'rightsourceip' => '192.168.56.1',
              'rightsubnet' => '192.168.56.0/24',
          },
      }
}
    
  context "Should install libreswan with one connection and one secret RedHat" do
    let(:facts) {
      { :osfamily => 'RedHat',
        :operatingsystem => 'RedHat',
        :operatingsystemrelease => '6.0',
        :concat_basedir => '/tmp',
        :kernel => 'Linux',
        :id => 'root',
        :path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      }
    }
    let(:params) {
      { :purge_configdir => false,
        :ipsec_config => ipsec_config,
        :secrets => secrets,
        :connections => connections,
      }
    }
    
    it do
      should contain_class('libreswan').with(
          'ipsec_config' => {
              'dumpdir' => '/var/run/pluto/',
              'nat_traversal' => 'no',
              'oe' => 'off',
              'protostack' => 'netkey',
              'force_keepalive' => 'yes',
              'config_keep_alive' => '60',
          }
      )

      should contain_libreswan__secret('test-secret').with(
          'ensure' => 'present',
          'id'     => '192.168.55.1 192.168.56.1',
          'type'   => 'PSK',
          'secret' => 'super-secret',
      )
      should contain_libreswan__conn('test-connection').with(
          'ensure' => 'present',
          'options'   => {
              'authby' => 'secret',
              'pfs'  => 'yes',
              'auto' => 'start',
              'left' => '192.168.55.1',
              'leftsourceip' => '192.168.55.1',
              'leftsubnet' => '192.168.55.0/24',
              'right' => '192.168.56.1',
              'rightsourceip' => '192.168.56.1',
              'rightsubnet' => '192.168.56.0/24',
          },
      )
    end
  end  

  
end
