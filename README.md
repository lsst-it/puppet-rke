# rke

## Table of Contents

1. [Overview](#overview)
1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)

## Overview

Installs [RKE1](https://github.com/rancher/rke) binary.

## Description

Fetches the `rke` utility and and symlinks `/usr/bin/rke` to the downloaded
artifact.

## Usage

```puppet
class { 'rke':
  version       => '1.3.3',
  checksum      => '61088847d80292f305e233b7dff4ac8e47fefdd726e5245052450bf05da844aa',
  checksum_type => 'sha256',
  base_path     => '/opt/rke',
}
```

## Reference

See [REFERENCE](REFERENCE.md)
