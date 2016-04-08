Fuel Infra's puppet manifests
-----------------------------

About
=====
Hi there,

This repo contains puppet manifests we're using in Fuel Infra to deploy our
services and CI's.

Repo structure
==============
Normally everything stored here could be just placed to ``/etc/puppet`` on puppet
master's (in case of ``puppet agent`` use) or target node (in case of ``puppet
apply``) use. In our Infra we're using puppet master and hiera to store
sensitive data like passwords and keys.

High level description for directories:
 * bin - scripts, which are impossible to use from puppet manifests (for puppet
   master installation for instance)
 * docs - dev docs describes functions of some modules and contains some
   examples
 * hiera - configuration examples for some of services
 * manifests - puppet native ``site.pp`` location
 * modules - puppet native modules location

How to contribute
=================
All of our flow goes through Gerrit to achieve code review purposes, so to
contribute something you need to login to review.fuel-infra.org with your LP
account and use standard Gerrit flow.

More details you can find here:
  http://docs.openstack.org/infra/manual/developers.html
The only difference is: we're using review.fuel-infra.org instance.

Code and style guides
=====================

Requirements
~~~~~~~~~~~~

#) Puppet files encoding must be ASCII
#) Host(s) configuration must be described in
   ``::fuel_project::roles::<ROLE_NAME>`` (even if it is only several lines)
#) site.pp file must describe exact node with the class from previous item
   only.
#) Each component(describes application) module must be splited into small
   atomic classes, independent from other ones.

  Example: Zabbix server module uses MySQL database, so Zabbix server must be
  installed as it's own module, database by it's own one.
  ::

    class zabbix::proxy
    class zabbix::database
    class zabbix::proxy
    class zabbix::server

#) Roles classes(located in ``::fuel_project::roles::<ROLE_NAME>``) must
   incldue ``::fuel_project::common`` class.
#) If there's a firewall requirement it must be implemented as
   ``$firewall_enable`` boolean attribute, set to false by default.
#) All specific rules, must be passed as a hash called
   ``$firewall_allow_sources``, set to empty hash(``{}``) by default.
#) If specific application configuration takes place, it must be described in
   ``::fuel_project::apps::<APP_NAME>``
#) Classes within ``::fuel_project::roles::<ROLE_NAME>`` must not pass any
   attributes to invoked classes, except ones could be represented as system
   flags, like ``$firewall_enable``.
#) Component modules must not invoke anything within ``::fuel_project`` module.
#) All of meaning attributes must be represented in
   ``hiera/common-example.yaml`` with placeholder values.
#) If there are additional package repositories required, they must be
   described in ``common-example.yaml``
#) Resource declarations must contain all the requirements in ``require``
   attribute.
#) Resouce chains(Resource -> Resource2 ~> Resource3) must not be used.
#) ``require`` attribute must contain references to the resources in the same
   module only.
#) Packages definition must have required='present' or
   required='package_version'.
#) Third-party modules must be installed via ``bin/install_modules.sh`` only.
#) Class attributes names must be in te following format ``{object_action}``

   Example::

     $firewall_enable

#) Class and definition declarations must be covered with puppet docstrings
#) You must declare resources with ``ensure_*`` functions if duplicate
   declaration error is expected, except the cases when you need to fail with
   duplicate declaration.
#) If declarations must be with brackets.

   Example::

     if (condition) {
       ...
     }

#) Class attributes, ``hiera/common-example.yaml`` values must be sorted
   alphabetically.
#) Commit message must describe all the changes in the review.
#) Commit message must contain 'Closes-Bug: #XXXXXXX' if the patchset fixes the
   bug, 'Related-Bug: #XXXXXXX' if it's a part of a bug(if there's a bug
   exists, of course).
#) CI must be passed.

Recomendations
~~~~~~~~~~~~~~

#) Manifests complete state should be achieved with the only pass.
#) You should avoid usage new applications if there is already present one
   covers the same needs.
