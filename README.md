# simple_nodejs
Clase de Puppet encargada de instalar y configurar NodeJS para CentOS 7.

#### Table of Contents

### What simple_motd affects
The simple_nodejs class it's a solution to install and configure NodeJS into CentOS 7 servers, creating needed users to run and installing oracle-instantclient from a localrepository defined on parameters, and at last the OracleDB node's module using npm.

### Beginning with simple_motd
To be used just need to place the simple_nodejs folder on your Puppet's module folder, import the class and it's ready to be used.

## Limitations
Just tested on CentOS 7.
