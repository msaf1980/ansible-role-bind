#! /usr/bin/env bash

####################################################################
# Workarounds for some bugs
if [ -f /etc/redhat-release ]; then
    major_version=$( rpm -E %{rhel} )


    [ "${major_version}" == "7" -o "${major_version}" == "6" ] && {
       # Bug in docker hosts OS overlayfs
       # Rpmdb checksum is invalid: dCDPT(pkg checksums):
       # https://stackoverflow.com/questions/51287437/docker-image-build-getting-check-sum-error-rpmdb-checksum-is-invalid-dcdpt    
       yum clean all
       yum install -y yum-plugin-ovl
    }
    #[ "${major_version}" == "7" ] && {
       # Firewalld fails to start because polkit doesn't allow it to claim the dbus path
       # https://bugzilla.redhat.com/show_bug.cgi?id=1575845
       #yum install -y firewalld
       #systemctl restart dbus
       #systemctl restart firewalld
       # https://bbs.archlinux.org/viewtopic.php?id=231728
       #[ -f /var/lib/ebtables/lock ] && rm  -f /var/lib/ebtables/lock
       # Not work, disable config SELinux/Firewalld
    #}
fi

exit 0
