#!/bin/bash

THREADS="16"
COMPRESSION_LEVEL="9"
TIMEOUT=16

if [ "${1}" = "" ]; then
	printf "Usage: %s VM_NAME\n" ${0}
	printf "Available VM's:"
	virsh list --name
fi

vmname="${1}"
echo "[+] Processing VM '""${vmname}""'"
printf "  [-] dumping VM %s XML to /tmp/%s.xml\n" "${vmname}" "${vmname}"
virsh dumpxml "${vmname}" > "/tmp/${vmname}.xml"

if [ "$?" != "0" ]; then echo Aborting...; exit; fi

BAKFILES="/tmp/${vmname}.xml"
for diskxml in $(cat "/tmp/${vmname}.xml" |  xpath -e "domain/devices/disk[@device='disk']/source/@file" 2> /dev/null); do
        DISKPATH=$( echo "${diskxml}" | cut -d\" -f2 )
        echo "  >> ADDING DISK ${DISKPATH}"
        BAKFILES="${BAKFILES} ${DISKPATH}"
done

#printf "compressing %s" "${BAKFILES}"

printf "  >> Shutting down VM: "
virsh shutdown "${vmname}"

while [ "$(virsh list --state-running --name | grep -F "${vmname}")" != "" ]; do
        TIMEOUT=$(expr $TIMEOUT - 1)
        echo "  ->> Domain still running... waiting 10secs... (${TIMEOUT} tries left)"
        if [ "${TIMEOUT}" = "0" ]; then
                echo "  ->> Timed out... Killing domain ${vmname}"
                virsh destroy "${vmname}"
        fi
        sleep 10s;
done

printf "  >> Starting backup process\n"

XZ_OPT="-${COMPRESSION_LEVEL} -T${THREADS}" tar cJf "VMBACKUP_${vmname}.tar.xz" ${BAKFILES}

printf "  >> Starting VM: "
virsh start  "${vmname}"
