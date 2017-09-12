# = Class: libreswan_config
#
class libreswan_config(
    $purge_configdir = false,
    $ipsec_config    = {},
    $secrets         = {},
    $connections     = {},
    $service_name    = 'ipsec',
    ) {


    # create default for create_resource calls later
    $create_default = {
        'notify' => "Service[${service_name}]"
    }


    # call libreswan class and pass config
    class {'libreswan':
        ipsec_config    => $ipsec_config,
        purge_configdir => str2bool($purge_configdir),
    }

    # create secrets if required
    if ($secrets) {
        validate_hash($secrets)
        create_resources('libreswan::secret', $secrets,$create_default)
    }

    # create connections if required
    if ($connections) {
        validate_hash($connections)
        create_resources('libreswan::conn', $connections,$create_default)
    }

}