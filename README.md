# tt-bandwidth-manager
Manage bandwidth usage via a systemd service by:
- setting global download and upload bandwidth limits
- setting per-process bandwidth limits
- prioritizing some processes higher than others

### Use cases
- Use the *bandwidth limits* if you pay for data by the MB; e.g. you don't want your audio or video calls to use more data than they absolutely need.
- Use *prioritization* if your available bandwidth is limited; e.g. you want to ensure that your audio calls go through, even if you're also downloading updates.

## Modifying the default bandwidth management configuration
The [default config](config/tt-default-config.yaml) is intentionally very conservative. It limits a couple of processes and gives some explanatory info. This config file requires elevated privileges to edit, e.g.:
```bash
$ sudo nano /etc/tt-config.yaml
```
This file is created during installation or an update only if it doesn't already exist. So if you make changes, they won't be lost after an update.

Explanations of configuration options can be found in the default config file at [/etc/tt-config.yaml](config/tt-default-config.yaml), as well as in an example file at [/usr/share/tt-bandwidth-manager/tt-example.yaml](config/tt-example.yaml) created by [cryzed](https://github.com/cryzed).

## Starting and stopping tt-bandwidth-manager.service
By default the service runs whenever there is a connection to the internet. It can be started and stopped with the usual systemd commands:
```bash
$ sudo systemctl restart tt-bandwidth-manager.service # e.g., if you change the config file
$ sudo systemctl stop tt-bandwidth-manager.service    # stop the service (restarts on reboot)
$ sudo systemctl disable tt-bandwidth-manager.service # prevent it from starting on reboot
$ sudo systemctl enable tt-bandwidth-manager.service  # allow it start on reboot
$ sudo systemctl start tt-bandwidth-manager.service   # start the service immediately
```

## Viewing the log file
Runtime logging can be found as with all systemd services using:
```bash
$ systemctl status tt-bandwidth-manager.service       # see if the service is running
$ journalctl -u tt-bandwidth-manager.service          # full historical log
$ journalctl -f -u tt-bandwidth-manager.service       # "follow" the log live
```
![screenshot](screenshot.png)

## Changing the network connection device
Normally, if you change your connection device (e.g. from Wi-Fi to Ethernet), **tt-bandwidth-manager** will recognize the

## About
**tt-bandwidth-manager** is based on the [TrafficToll](https://github.com/cryzed/TrafficToll) python3 package developed by [cryzed](https://github.com/cryzed), but it's built as a debian package and modified to run as a systemd service.

It's composed of 4 parts:
- The traffictoll python3 package whose executable is installed at /usr/bin/tt.
- A default config file installed at /etc/tt-config.yaml.
  - There is also an example config file at /usr/share/tt-bandwidth-manager/tt-example.yaml.
- A wrapper script installed at /usr/bin/tt-wrapper that:
  - selects the current networking device
  - selects the correct configuration file
  - starts the tt executable
- A service unit file called tt-bandwidth-manager.service that configures systemd to manage the process.
