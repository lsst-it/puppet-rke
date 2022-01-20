#
# @summary Install RKE binary
#
# @param version
#   RKE release version
#
# @param checksum
#   Artifact checksum string
#
# @param checksum_type
#   The digest algorithm used for the checksum string.
#
# @param base_path
#   Base path under which to install software.
#
class rke (
  String $version                 = '1.3.4',
  String $checksum                = '92440ec62468d329ca26829b2a1d5624aa7a5d37054596633e4e838549a22946',
  String $checksum_type           = 'sha256',
  Stdlib::Absolutepath $base_path = '/opt/rke',
) {
  $bin_path     = '/usr/bin'
  $dl_path      = "${base_path}/dl"
  $version_path = "${dl_path}/${version}"

  $uname        = 'linux'
  $arch         = 'amd64'
  $base_url     = "https://github.com/rancher/rke/releases/download/v${version}"
  $archive_file = "rke_${uname}-${arch}"
  $source       = "${base_url}/${archive_file}"

  file { [$base_path, $dl_path, $version_path]:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  archive { $archive_file:
    ensure        => present,
    checksum      => $checksum,
    checksum_type => $checksum_type,
    cleanup       => false,
    extract       => false,
    path          => "${version_path}/${archive_file}",
    source        => $source,
    require       => File[$version_path],
  }
  -> file { "${bin_path}/rke":
    ensure => link,
    target => "${dl_path}/rke",
  }
}
