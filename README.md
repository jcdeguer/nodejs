# nodejs
Clase de Puppet encargada de instalar y configurar NodeJS para CentOS 7.

#### Table of Contents
1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nodejs](#setup)
    * [What simple_nodejs affects](#what-nodejs-affects)
    * [Beginning with simple_nodejs](#beginning-with-nodejs)
4. [Limitations - OS compatibility, etc.](#limitations)

### What nodejs affects
The nodejs class it's a solution to install and configure NodeJS into CentOS 7 servers, creating needed users to run and installing oracle-instantclient from a localrepository defined on parameters, and at last the OracleDB node's module using npm.

### Beginning with nodejs
To be used just need to place the nodejs folder on your Puppet's module folder, import the class and it's ready to be used.

## Limitations
Just tested on Red Hat, CentOS, and Oracle Linux 7.x
