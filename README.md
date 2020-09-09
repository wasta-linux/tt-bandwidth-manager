# tt-bandwidth-manager
Manage bandwidth usage via a systemd service by:
- setting global (per-device) download and upload bandwidth limits
- setting per-process bandwidth limits
- prioritizing some process higher than others

**tt-bandwidth-manager** is just [TrafficToll](https://github.com/cryzed/TrafficToll) developed by [cryzed](https://github.com/cryzed), but built as a debian package and modified to run as a systemd service.

It's composed of 3 parts:
- the python3 package installed at /usr/local/bin/tt
- a config file installed at /usr/share/tt-bandwidth-manager/tt-config.yaml
  - There is also an example config file in the same folder called tt-example.yaml.
- a wrapper script installed at /usr/bin/tt-wrapper that applies the configuration to the currently used network device

By default the service runs whenever there is a connection to the internet. It can be started and stopped with the usual systemd commands:
- $ sudo systemctl start tt-bandwidth-manager.service
- $ sudo systemctl stop tt-bandwidth-manager.service
- $ sudo systemctl restart tt-bandwidth-manager.service # if you change the config file, for example.

Runtime logging can be found as with all systemd services using:
- $ systemctl status tt-bandwith-manager.service
- $ journalctl -u tt-bandwidth-manager.service
