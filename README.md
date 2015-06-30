# A Virtual Machine for Phoenix Development

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/maruware/phoenix-dev-box.git
    host $ cd phoenix-dev-box
    host $ vagrant up

That's it.

After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh
    Welcome to Ubuntu 14.04.2 LTS (GNU/Linux 3.13.0-55-generic x86_64)
    ...
    vagrant@phoenix-dev-box:~$

## What's In The Box

* Development tools

* Git

* Elixir

* Phoenix

* MySQL, and Postgres

* Database initial users - dev_user and test_user

* System dependencies for mysql, mysql2, and pg

* Memcached

* Redis

* RabbitMQ

* An ExecJS runtime
