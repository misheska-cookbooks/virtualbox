# virtualbox

This cookbook installs the VirtualBox desktop virtualization software.
NOTE: Currently only the Mac OS X platform is supported.

# Overview

Install the Chef Development Kit, available via http://downloads.getchef.com

On Mac OS X and Linux, configure the PATH and GEM environment variables with:

    $ eval "$(chef shell-init bash)"

All cookbook-related development activities are Rake tasks:

Attributes
==========

The attributes used in this cookbook are in the the `node['virtualbox']`
namespace:

Attribute     | Description | Type | Default
--------------|-------------|------|--------
url           | Download URL for VirtualBox package (overrides version) | String | nil
version       | VirtualBox version to install.  This value is ignored if `url` is set.  Verison should be in the form of 'x.y.z' or 'latest' | String | 'latest'

Recipes
=======

Here's the recipes for this cookbook and how to use them in your environment:

default
-------
Installs the VirtualBox desktop virtualization software.

Alternative Install Methods
==========================

## Bootstrapping with chef-solo

In situations where this cookbook is being used in an environment where there
is no Chef Server, this cookbook can be installed via `chef-solo` using the
following command:

    $ rake bootstrap
