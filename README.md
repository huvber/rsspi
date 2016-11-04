# RSSPI

A small daemon to download torrents from rss feeds and add it to transmission

## Requirements
  * systemd
  * node
  * coffeescript

for raspian users:
```
  $ sudo apt-get install nodejs, coffeescript
```

for archlinuxarm users:
```
  $ sudo pacman -S nodejs coffee-script
```

## Install

1. First clone this repository to /opt/rsspi

  ```
    # cd /opt; git clone https://github.com/huvber/rsspi.git
  ```
2. edit the `config.coffee` file to add your feed and the folder where transmission is watching

3. make `index.coffee` executable
  ```
    # chmod +x index.coffee
  ```
4. copy the file `rsspi.service`  to **/etc/systemd/system**

  ```
    # cp rsspi.service /etc/systemd/system/rsspi.service
  ```

  ```
    # systemctl daemon-reload
  ```
5. Enable and start _rsspi_ service

  ```
    # systemctl enable rsspi
  ```

  ```
    # systemctl start rsspi
  ```

If you wants to check the status of the daemon you should run _journalctl_

```
# journalctl --follow -u rsspi
```
