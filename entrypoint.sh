#!/bin/bash
set -e

source ${GITLAB_MIRROR_ASSETS}/functions

add_user
fix_home_permissions
check_environment
configure_gitlab_mirror

ARG="$(echo -e "${1}" | tr -d '[:space:]')"
case "${ARG}" in
        "mirrors")
                echo exec_as_user "${GITLAB_MIRROR_INSTALL_DIR}/git-mirrors.sh" ${@:2}
                exec_as_user "${GITLAB_MIRROR_INSTALL_DIR}/git-mirrors.sh" ${@:2}
                ;;
        "add")
                exec_as_user "${GITLAB_MIRROR_INSTALL_DIR}/add_mirror.sh" ${@:2}
                ;;
        "delete")
                exec_as_user "${GITLAB_MIRROR_INSTALL_DIR}/delete_mirror.sh" ${@:2}
                ;;
        "ls")
                exec_as_user "${GITLAB_MIRROR_INSTALL_DIR}/ls-mirrors.sh" ${@:2}
                ;;
        "update")
                echo "update"
                echo exec_as_user "${GITLAB_MIRROR_INSTALL_DIR}/update_mirror.sh" ${@:2}
                exec_as_user "${GITLAB_MIRROR_INSTALL_DIR}/update_mirror.sh" ${@:2}
                ;;
        "config")
                echo "Populated /config volume, please add ssh keys and configuration"
                ;;
        "run")
                exec_as_user "${@:2}"
                ;;
	"help")
		echo "Available options:"
		echo " mirrors           - Update all mirrors"
		echo " add               - Add a new mirror"
		echo " delete            - Delete a mirror"
		echo " ls                - List registered mirrors"
		echo " update <project>  - Update a single mirror"
		echo " config            - Populate the /config volume with ~/.ssh and other things"
		echo " run <command>     - Run an arbitrary command inside the container"
		;;
        *) exit 3
esac

