# = Class: libreswan_config
#
class libreswan_config(
    $purge_configdir = false,
    $ipsec_config    = {},
    $secrets         = {},
    $connections     = {},
    ) {

    # call libreswan class and pass config
    class {'libreswan':
        ipsec_config    => $ipsec_config,
        purge_configdir => str2bool($purge_configdir),
    }

    # create secrets if required
    if ($secrets) {
        validate_hash($secrets)
        create_resources('libreswan::secret', $secrets)
    }

    # create connections if required
    if ($connections) {
        validate_hash($connections)
        create_resources('libreswan::conn', $connections)
    }

}
