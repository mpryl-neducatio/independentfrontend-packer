#Development and production machine images created with *puppet* + *packer* + *amazon aws* + *virtualbox* + *vagrant*
######Centralized configuration of dev and prod machine images with one JSON configuratin file and provisioning scripts

Using this configuration you can derive benefits of michaelszymczak https://github.com/michaelszymczak/independentfrontend machine configuration on your development machine as well as on production.

##Credits
This work was inspired by:
+ https://github.com/michaelszymczak/independentfrontend
+ http://www.packer.io/
+ http://www.ipponusa.com/from-development-to-production-with-vagrant-and-packer/
+ http://pretengineer.com/post/packer-vagrant-infra/
+ https://github.com/aseigneurin/vms
+ https://github.com/ffuenf/vagrant-boxes

##Goal
The goal of this project is to:
+ deploy applications very fast on production (e.g. amazon aws)
+ speed up development workflow (start custom already provisioned machine)
+ extends own machines using previous one instead of patching provisioning scripts
+ easly and fast create and start new machines on production evironment (e.g. using ebs machine image on amazon aws)
+ not depends on vagrant boxes available publicly

##How to start

1. Tools installation
---

1. Install the newest version of [Virtualbox](https://www.virtualbox.org/wiki/Downloads).
3. Install the newest version of [Vagrant](https://www.vagrantup.com/downloads).
4. Install the newest version of [Packer](http://www.packer.io/downloads.html) and follow installation guide http://www.packer.io/intro/getting-started/setup.html.
5. Clone project and go to project's directory - it'll be the project root directory.

2. Build dev machine
---

1. Be sure you're in the the project root directory (where the example.json is located) and type `packer validate example.json`
2. The output should be `Template validated successfully.`
3. If there is everything ok, we can build our virtualbox image with command `packer build -only virtualbox-iso example.json`
4. This will take a while ... ;)
5. In the end this build should create catalog with virtualbox image and box named `ubuntu-14.04-server-amd64_virtualbox.box`
6. You've just created, provisioned and save image of your dev server.
7. You can add just created box to vagrant `vagrant box add ubuntu-14.04-server-amd64 ubuntu-14.04-server-amd64_virtualbox.box`
8. And start working starting up your machine with `vagrant up --provider=virtualbox`

3. Build prod machine
---

There is one **PROBLEM** I do not really know *puppet* and I do not know how to change from vagrant to ubuntu user in puppet provisioning files. So you have to change **all** occurances of `vagrant` in folder `provisioning\manifests\modules` to `ubuntu` and rename file `provisioning\manifests\modules\server\manifest\apache\configured_for_vagrant.pp` to `provisioning\manifests\modules\server\manifest\apache\configured_for_ubuntu.pp`.

**Sory for that**

1. Be sure you're in the the project root directory (where the example.json is located) and type `packer validate example.json`
2. The output should be `Template validated successfully.`
3. If there is everything ok, we can build our amazon ebs image with command `packer build -only amazon-ebs -var 'aws_access_key=YOUR_ACCESS_KEY' -var 'aws_secret_key=YOUR_SECRET_KEY'`
4. In the end this build should create ami on amazon and box named `ubuntu-14.04-server-amd64_aws.box`
5. You've just created, provisioned and save image of your prod server on your amazon account.
6. You can now start new micro instance on amazon using just created ami or you can use it as your development machine using vagrant-aws provider plugin.
7. To use it as your development machine add just created box to vagrant `vagrant box add ubuntu-14.04-server-amd64 ubuntu-14.04-server-amd64_aws.box`
8. And start working starting up your machine with `AWS_ACCESS_KEY=YOUR_ACCESS_KEY AWS_SECRET_KEY=YOUR_SECRET_KEY vagrant up --provider=aws`
9. I have not tested using this machine with vagrant, because on Windows there are problems with connecting by SSH using private key.

####All of that was created and tested on laptop with Windows 8 operating system and I don't make promise that this will work as it is on every system

####Pull request are very welcom :D

4. What's next?
---
You can check michaelszymczak https://github.com/michaelszymczak/independentfrontend repository to start working on your super new server and develop amazing web apps!
