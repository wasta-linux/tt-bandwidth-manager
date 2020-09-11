# tt-bandwidth-manager
Manage bandwidth usage via a systemd service by:
- setting global (per-device) download and upload bandwidth limits
- setting per-process bandwidth limits
- prioritizing some process higher than others

### Use cases
Use the bandwidth limits if you pay for data by the MB; e.g. you don't want your audio or video calls to use more data than they absolutely need.
Use prioritization if your available bandwidth is limited; e.g. you want to ensure that your audio calls go through, even if you're also downloading updates.

### About
**tt-bandwidth-manager** is based on [TrafficToll](https://github.com/cryzed/TrafficToll) python3 package developed by [cryzed](https://github.com/cryzed), but it's built as a debian package and modified to run as a systemd service.

It's composed of 4 parts:
- The traffictoll python3 package whose executable is installed at /usr/local/bin/tt.
- A default config file installed at /etc/tt-bandwidth-manager/tt-config.yaml.
  - There is also an example config file in the same folder called tt-example.yaml.
- A wrapper script installed at /usr/bin/tt-wrapper that:
  - selects the current networking device
  - selects the correct configuration file
  - starts the tt executable
- A service unit file called tt-bandwidth-manager.service that configures systemd to manage the app.

### Modifying the default bandwidth management configuration
The default config is intentionally very conservative. It limits a couple of processes and gives some explanatory info. This config file requires elevated privileges to edit, so for convenience you may create a user config file under ~/.config/ like this:
```bash
$ cp /usr/share/tt-bandwidth-manager/tt-config.yaml $HOME/.config/tt-config.yaml
```
If this file exists, **tt-bandwidth-manager** will use it instead of the default file.
> NOTE: This is currently designed as a system-wide service, so in the case that multiple users each have their own config file, the most recently modified user config file will be used. Likewise, if only one of multiple users has their own config file, it will still be applied system wide and affect any other users.

### Starting and stopping tt-bandwidth-manager.service
By default the service runs whenever there is a connection to the internet. It can be started and stopped with the usual systemd commands:
```bash
$ sudo systemctl restart tt-bandwidth-manager.service # e.g., if you change the config file
$ sudo systemctl stop tt-bandwidth-manager.service    # temporarily stop bw management (restarted on reboot)
$ sudo systemctl disable tt-bandwidth-manager.service # prevent it from starting on reboot
$ sudo systemctl enable tt-bandwidth-manager.service  # allow it start on reboot
$ sudo systemctl start tt-bandwidth-manager.service   # start the service immediately
```

### Viewing the log file
Runtime logging can be found as with all systemd services using:
```bash
$ systemctl status tt-bandwidth-manager.service       # see if the service is running and last few lines of log output
$ journalctl -u tt-bandwidth-manager.service          # full historical log
$ journalctl -f -u tt-bandwidth-manager.service       # "follow" the log live
```
