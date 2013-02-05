define wix::installation(
  $version     = $title,
  $source      = undef,
  $destination = 'C:\packages'
) {

  if $source {
    $location = $source

  } else {
    if $version =~ /35/ {
      $pkg_name = "wix${version}.msi"
      $install_opts = [ '/q', '/norestart' ]
    } else {
      $pkg_name = "wix${version}.exe"
      $install_opts = ''
    }
    $location = "puppet:///modules/${module_name}/${pkg_name}"
  }

  $on_disk = "${destination}\\${pkg_name}"

  file { $on_disk:
    ensure => file,
    source => $location,
    mode   => '750',
  }

  package { 'WiX Toolset':
    ensure => present,
    source => $on_disk,
    install_options => $install_opts
  }
}
