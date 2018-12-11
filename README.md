# libvirtdbackups

Bash Script to create a libvirtd disk+xml backup

## Usage
  
```Bash
./virtbackup.sh CENTOS7
```

## Output

```
[+] Processing VM 'CENTOS7'
  [-] dumping VM CENTOS7 XML to /tmp/CENTOS7.xml
  >> ADDING DISK /mnt/storage/diskc7-ROOT.img
  >> ADDING DISK /mnt/storage/diskc7-HOME.img
  >> Shutting down VM: Domain CENTOS7 is being shutdown

  ->> Domain still running... waiting 10secs... (15 tries left)
  ->> Domain still running... waiting 10secs... (14 tries left)
  ->> Domain still running... waiting 10secs... (13 tries left)
  ->> Domain still running... waiting 10secs... (12 tries left)
  ->> Domain still running... waiting 10secs... (11 tries left)
  ->> Domain still running... waiting 10secs... (10 tries left)
  ->> Domain still running... waiting 10secs... (9 tries left)
  ->> Domain still running... waiting 10secs... (8 tries left)
  ->> Domain still running... waiting 10secs... (7 tries left)
  ->> Domain still running... waiting 10secs... (6 tries left)
  ->> Domain still running... waiting 10secs... (5 tries left)
  >> Starting backup process
tar: Removing leading `/' from member names
  >> Starting VM: Domain CENTOS7 started
```

## Requirements
  
- xpath (libxml-xpath-perl)
- tar
- xz (new version supporting threads)
- virsh
- libvirtd
- Access and permissions to read disks
