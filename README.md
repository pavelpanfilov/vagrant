Windows 10 hyper-v

Run PS as admin

1. Create custom network switch in hyper-v called 'LAN'

2. Install plugins:
```shell
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-hostmanager
```
3. Check paths to keys, ip addresses. Start vms, update hosts files after provisioning:
```shell
vagrant up
vagrant provision --provision-with hostmanager
```