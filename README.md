# iocage-plugin-komga
Artifact file(s) for komga iocage plugin

https://komga.org/

## Installation

```
sudo iocage fetch -P komga -n komga -g https://github.com/fuji44/iocage-fuji44-plugins.git ip4_addr="em0|192.168.0.100/24"
```

## Usege

After the installation is complete, go to the following URL You will need to create a user only the first time.

http://your_ip_addr:8080/

## Configure

By accessing the console of the plugin (Jail), you can configure settings that cannot be done with the WebUI.

### application.yml

You can modify `/usr/local/komga/application.yml` to customize the behavior of Komga.

See [the official documentation](https://komga.org/installation/configuration.html) for more details on the settings.

After making the changes, service reboot.

```
service komga restart
```

### komga-plugin.conf

The rc script and utility commands provided by this plugin depend on the variables in `/usr/local/etc/komga-plugin.conf`. See the comments in the file for each variable.

Note: `komga-plugin.conf` has nothing to do with the internal workings of the Komga application.

### [Increase memory limit](https://komga.org/installation/jar.html#increase-memory-limit)

To increase the upper limit of memory used by java, specify `KOMGA_JAVA_OPTS` in `komga-plugin.conf`. This will be passed to the java command executed by rc script (`/usr/local/etc/rc.d/komga`). If you want to specify multiple options, separate them with a space.

```
KOMGA_JAVA_OPTS=-Xmx4g
```

## Maintenance

Several commands are available to assist in the operation of the plugin. For more information on each command, see the command help.

- `komga-backup` : Backup Komga database file.
- `komga-clean-backup` : Delete the old backup files.
- `komga-clean-jar` : Delete the old JAR files.
- `komga-update` : Update the komga JAR file to the latest version.

### Plugin update

It is recommended that you `iocage update` the `komga-update` command instead of running it directly. This is because `komga-update` updates the Komga JAR file, but does not update the plugin-related commands.

```
sudo iocage update komga
```

### Backup and Restore DB

Execute the `komga-backup` command to back up database files of komga. You can change the behavior of the command depending on your settings and options, but it will work without specifying anything.

Of course, you can also use the `cp` or `sqlite3` command to backup.

There is no command for restoring at this time. Please use `cp` or something similar to place it in the original path.
