#!/usr/bin/env bash

set -eou pipefail

: "${HOST_USER_ID?Please set HOST_USER_ID environment variable. (Run 'id -u' to get the value.)}"
: "${HOST_GROUP_ID?Please set HOST_GROUP_ID environment variable. (Run 'id -g' to get the value.)}"

RUN_AS_UID=${HOST_USER_ID:-9999}
RUN_AS_GID=${HOST_GROUP_ID:-9999}

RUN_AS_USER_NAME=${CONTAINER_USER_NAME:-containeruser}
RUN_AS_GROUP_NAME=${CONTAINER_GROUP_NAME:-containergroup}

# Create a group/gid combination if it's not already present
if getent group "$RUN_AS_GID" &> /dev/null; then
    RUN_AS_GROUP_NAME=$(getent group "$RUN_AS_GID" | cut -d: -f1)
else
    groupadd --gid "$RUN_AS_GID" "$RUN_AS_GROUP_NAME"
fi

# Create a user/uid combination if it's not already present
if getent passwd "$RUN_AS_UID" &> /dev/null; then
    RUN_AS_USER_NAME=$(getent passwd "$RUN_AS_UID" | cut -d: -f1)
else
    useradd --no-user-group --create-home --shell /bin/bash --uid "$RUN_AS_UID" --gid "$RUN_AS_GID" "$RUN_AS_USER_NAME"
fi

# Append the user to the conda group
usermod --append --groups "$CONDA_GROUP" "$RUN_AS_USER_NAME"

# Prepare $HOME and $PATH before switching user
export HOME="/home/$RUN_AS_USER_NAME"

# This code path should not be hit easily. Print information if it arrives here.
if [ "$RUN_AS_UID" -eq 9001 ] || [ "$RUN_AS_GID" -eq 9001 ]; then
    cat <<-EOF

	**********************************************************************************************
	* You have not passed in either the HOST_USER_ID or the HOST_GROUP_ID environment variable.  *
	* This could be because of some error or you are not using the Makefile helpers.             *
	**********************************************************************************************
	* As a result, your app and cache dir will be chowned by user:group=9001:9001                *
	* To fix this, run `chown -R $(id -u):$(id -g) ./` on the project directory on host OS.      *
	**********************************************************************************************
	* Check the Makefile and entrypoint.sh for more details                                      *
	**********************************************************************************************

	EOF
fi

# Own the file before switching the user
chown -R "$RUN_AS_UID":"$RUN_AS_GID" "$APP_DIR" "$CACHE_DIR"


# Print the user/uid - group/gid to start with
cat <<EOF

***************************************************************************
Starting as : uid($RUN_AS_UID)$RUN_AS_USER_NAME | gid($RUN_AS_GID)$RUN_AS_GROUP_NAME
***************************************************************************

EOF

# Switch to the user:group and exec
setpriv --reuid="$RUN_AS_UID" --regid="$RUN_AS_GID" --init-groups "$@"
# exec gosu "$RUN_AS_UID":"$RUN_AS_GID" "$@"
