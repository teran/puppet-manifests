Fuel Infra's puppet manifests
-----------------------------

About
=====
Hi there,

This repo contains puppet manifests we're using in Fuel Infra to deploy our
services and CI's.

Repo structure
==============
Normally everything placed here could be just placed to `/etc/puppet` on puppet
master's(in case of `puppet agent` use) or target node(in case of `puppet
apply`) use. In our Infra we're using puppet master and hiera to store
sensitive data like passwords and keys.

High level description for directories:
 * bin - scripts, which are impossible to use from puppet manifests(for puppet
   master installation for instance)
 * docs - dev docs describes functions of some modules and contains some
   examples
 * manifests - puppet native `site.pp` location
 * modules - puppet native modules location

How to contribute
=================
All of our flow goes through Gerrit to achieve code review purposes, so to
contribute something you need to login to review.fuel-infra.org with your LP
account and use standard Gerrit flow.

More details you can find here:
  http://docs.openstack.org/infra/manual/developers.html
The only difference is: we're using review.fuel-infra.org instance.
