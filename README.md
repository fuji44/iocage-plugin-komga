# iocage-plugin-komga
Artifact file(s) for komga iocage plugin

https://komga.org/

## Installation

```
sudo iocage fetch -P komga -n komga -g https://github.com/fuji44/iocage-fuji44-plugins.git --branch main ip4_addr="em0|192.168.0.100/24"
```

## Usege

After the installation is complete, go to the following URL You will need to create a user only the first time.

http://your_ip_addr:8080/

## Configure

By accessing the console of the plugin (Jail), you can configure settings that cannot be done with the WebUI.

### Config file

You can modify `/usr/local/komga/application.yml` to customize the behavior of your application.

See [the official documentation](https://komga.org/installation/configuration.html) for more details on the settings.

After making the changes, service reboot.

```
service komga restart
```

### [Increase memory limit](https://komga.org/installation/jar.html#increase-memory-limit)

To increase the upper limit of memory used by java, do the following. This will be passed to the java command executed by rc script (`/usr/local/etc/rc.d/komga`).

```
sysrc komga_java_opts="-Xmx4g"
```
