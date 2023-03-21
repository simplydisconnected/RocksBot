RocksBot
========

Rocksbot is a Perl IRC bot based on the Perl Object Environment (POE) framework.  Rocksbot is multi-threaded, can run as a daemon (if desired), and is extensible via plugins.  Sample plugins are provided.

Rocksbot supports user accounts and has a highly customizable permissions system, as well as a built-in help system. For developers, built-in functions make saving and retrieving data, grabbing URLS, publishing HTML pages, and shortening URL's a snap.  All data is stored in a sqlite database.

Rocksbot makes use of "command line" flags to make argument order less important.  (Example:  login -password=blah).

Commands can be piped, similar to many *nix command shells.  (Example: To get a fortune, translate it to german, then color the output like a rainbow:  .fortune | german | rainbow )

Rocksbot is available according to the terms the GNU General Public License, version 3 (GPLv3).

Running in a Container
------------

1.  Make sure you have docker installed for your operating system
2.  Run bin/build.sh to build the image.
3.  Copy rocksbot.cfg.sample to etc/rocksbot.cfg.
4.  Edit rocksbot.cfg with your desired settings.
5.  Run bin/create.sh to create the container.
5.  Run docker start rocksbot and docker stop docker stop rocksbot to start and stop the bot.  You can also run docker logs -f rocksbot to monitor its output.

You can migrate an existing RocksBot into a container by copying database.sqlite into the data directory and rocksbot.cfg into the etc directory.  Take care to update the DatabaseFile, daemon_logfile and daemon_pidfile in your rocksbot.cfg to match rocksbot.cfg.sample.

Getting started
---------------
On first run, an admin user will be created using the username and password specified in the config file.  You should log-in (login -username=whatever -password=whatever) and change the admin password.

To get information about the installed plugins, issue the .help command.  (Assuming that you're using a . as the bot command prefix.)  To get a list of commands contained in each plugin, issue a .help PluginName.  To get help with a particular command, issue a .help CommandName, or .help PluginName CommandName.  To get information about a command + flag combo, use .help CommandName -flag.  To get general information about a command or plugin, use .help --info.  To generate a customized HTML help file, use .allhelp

