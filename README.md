# tt-bandwidth-manager
Manage bandwidth usage via a systemd service by:
- setting global (per-device) download and upload bandwidth limits
- setting per-process bandwidth limits
- prioritizing some process higher than others

**tt-bandwidth-manager** is just [TrafficToll](https://github.com/cryzed/TrafficToll) developed by [cryzed](https://github.com/cryzed), but built as a debian package and modified to run as a systemd service.

It's composed of 3 parts:
- the python3 package installed at /usr/local/bin/tt
- a default config file installed at /usr/share/tt-bandwidth-manager/tt-config.yaml
  - There is also an example config file in the same folder called tt-example.yaml.
- a wrapper script installed at /usr/bin/tt-wrapper that applies the configuration to the currently used network device

### Modifying the default bandwidth management configuration
The default config is intentionally very conservative. It limits a couple of processes and gives some explanatory info. Because any modifications to the default file will be overrwritten by updates, it is recommended that you create an override config file under ~/.config/ like this:
$ cp /usr/share/tt-bandwidth-manager/tt-config.yaml $HOME/.config

**tt-bandwidth-manager** will choose this file over the default file if it exists.
NOTE: This is currently designed as a system-wide service, so in the case that
multiple users each have their own config override, the most recently modified
config override file will be used.

### Starting and stopping tt-bandwidth-manager.service.
By default the service runs whenever there is a connection to the internet. It can be started and stopped with the usual systemd commands:
- $ sudo systemctl start tt-bandwidth-manager.service
- $ sudo systemctl stop tt-bandwidth-manager.service
- $ sudo systemctl restart tt-bandwidth-manager.service # if you change the config file, for example.

Runtime logging can be found as with all systemd services using:
- $ systemctl status tt-bandwith-manager.service
- $ journalctl -u tt-bandwidth-manager.service
