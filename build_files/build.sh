#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 
dnf install -y @cosmic-desktop-environment

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

. /usr/lib/os-release

IMAGE_NAME="mintaka"
IMAGE_PRETTY_NAME="Mintaka"
HOME_URL="https://github.com/hbdesiato/mintaka"
DOCUMENTATION_URL="https://github.com/hbdesiato/mintaka"
SUPPORT_URL="https://github.com/hbdesiato/mintaka/issues"
BUG_SUPPORT_URL="https://github.com/hbdesiato/mintaka/issues"

sed -i "s|^VARIANT_ID=.*|VARIANT_ID=$IMAGE_NAME|" /usr/lib/os-release
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"${IMAGE_PRETTY_NAME} (Version: ${VERSION})\"|" /usr/lib/os-release
sed -i "s|^NAME=.*|NAME=\"$IMAGE_PRETTY_NAME\"|" /usr/lib/os-release
sed -i "s|^HOME_URL=.*|HOME_URL=\"$HOME_URL\"|" /usr/lib/os-release
sed -i "s|^DOCUMENTATION_URL=.*|DOCUMENTATION_URL=\"$DOCUMENTATION_URL\"|" /usr/lib/os-release
sed -i "s|^SUPPORT_URL=.*|SUPPORT_URL=\"$SUPPORT_URL\"|" /usr/lib/os-release
sed -i "s|^BUG_REPORT_URL=.*|BUG_REPORT_URL=\"$BUG_SUPPORT_URL\"|" /usr/lib/os-release
sed -i "s|^CPE_NAME=\"cpe:/o:fedoraproject:fedora|CPE_NAME=\"cpe:/o:universal-blue:${IMAGE_PRETTY_NAME,}|" /usr/lib/os-release
sed -i "s|^DEFAULT_HOSTNAME=.*|DEFAULT_HOSTNAME=\"${IMAGE_PRETTY_NAME,}\"|" /usr/lib/os-release
sed -i "s|^ID=fedora|ID=${IMAGE_PRETTY_NAME,}\nID_LIKE=\"${IMAGE_LIKE}\"|" /usr/lib/os-release
sed -i "s|^IMAGE_ID=.*|IMAGE_ID=$IMAGE_NAME|" /usr/lib/os-release

rm /usr/share/backgrounds/default.jxl
ln -s cosmic/orion_nebula_nasa_heic0601a.jpg /usr/share/backgrounds/default.jxl
rm /usr/share/backgrounds/default-dark.jxl
ln -s cosmic/orion_nebula_nasa_heic0601a.jpg /usr/share/backgrounds/default-dark.jxl

#### Example for enabling a System Unit File

# systemctl enable podman.socket
systemctl disable gdm.service
systemctl enable cosmic-greeter.service
