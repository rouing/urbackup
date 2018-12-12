# urbackup
UrBackup Server in a Docker but always up to date [Version Tagging Included]

[![Docker Automated buil](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)](https://hub.docker.com/r/rouing/urbackup/) 

[![pipeline status](https://git.rouing.me/docker/urbackup/badges/master/pipeline.svg)](https://git.rouing.me/docker/urbackup/commits/master)


UrBackup is an easy to setup Open Source client/server backup system, that through a combination of image and file backups accomplishes both data safety and a fast restoration time.

[www.urbackup.org](https://www.urbackup.org/index.html)


### Pull:
```bash
docker pull rouing/urbackup
```

```bash
docker pull docker.rouing.me/docker/urbackup
```

### Run:
```bash
docker run \
--name urbackup \
--restart=always \
-v /etc/localtime:/etc/localtime:ro \
-v /home/docker/urbackup/db/:/var/urbackup \
-v /some-distributed-filesystem/backup/:/backup \
--net="host" \
-d rouing/urbackup
```

### WebUI
`host:55414`

### Show all Cli Commands
```bash
docker run \
--rm rouing/urbackup --help
```

### Remove-Unkown
Cleaning the backup folder of files not known by UrBackup Database  
[urbackup documentation](https://www.urbackup.org/administration_manual.html#x1-10000011.4)  
```bash
docker run \
-v /home/docker/urbackup/db/:/var/urbackup \
-v /some-distributed-filesystem/backup/:/backup \
--rm rouing/urbackup remove-unknown
```

### Cleanup
Percent of space to free on the backup storage or the number of Bytes/ Megabytes/ Gigabytes e.g. “20G” or “10%”.  
If it should only delete old backups use “0%”.  
[urbackup documentation](https://www.urbackup.org/administration_manual.html#x1-9900011.3)  
```bash
docker run \
-v /home/docker/urbackup/db/:/var/urbackup \
-v /some-distributed-filesystem/backup/:/backup \
--rm rouing/urbackup cleanup --amount 0%
```

### Network Mode
if you don't want to use net="host" you can expose the following ports
```bash
-p 55413-55415:55413-55415 \
-p 35623:35623 \
```

### Build
```bash
$ git clone https://git.rouing.me/docker/urbackup.git # or https://github.com/rouing/urbackup
$ cd urbackup
$ docker build -t rouing/urbackup-docker .
```

### Important - First Start
- on the first start urbackup complains about the backup directory  
- set /backup to your backup directory (settings)  
- mount this directory to your actual backup directory on your host  
`-v /some-distributed-filesystem/backup/:/backup`
- ensure correct permissions on the host folders your mounting  
e.g.  
```bash
chmod 777 -R /home/docker/urbackup/  
chmod 777 -R /some-distributed-filesystem/backup/
```


Based on tristanteu/urbackup-docker but with automated version pulling and version tagging
