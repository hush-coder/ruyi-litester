
function LOG_PRINT() {
	local level=$1
	shift

	echo "$(date +%Y-%m-%d\ %T)  $0  [ $level  ]  $@"
}

function LOG_INFO() {
	LOG_PRINT "INFO" $@
}

function LOG_WARN() {
	LOG_PRINT "WARN" $@
}

function LOG_ERROR() {
	LOG_PRINT "ERROR" $@
}

function CHECK_RESULT() {
	local result=$1
	local result_expect=${2-0}
	local check_mode=${3-0}
	local error_msg=$4
	local exit_on_error=${5-0}

	if [ -z "$result" ] || [ -z "$result_expect" ] || [ -z "$check_mode" ]; then
		LOG_ERROR "Too few argument!"
	fi

	if [[ "$result" != "$result_expect" ]]; then
		LOG_ERROR "$error_msg"
		LOG_ERROR "${BASH_SOURCE[1]} line ${BASH_LINENO[0]}"
		((RIT_MUGEN_ERROR_COUNT++))
		if [ $exit_on_error -eq 1 ]; then
			exit 1
		fi
	fi

	return 0
}

function PKG_INSTALL() {
	local arch_flag=
	local arch_pkg=
	local debian_flag=
	local debian_pkg=
	local fedora_flag=
	local fedora_pkg=
	local gentoo_flag=
	local gentoo_pkg=
	local ubuntu_flag=
	local ubuntu_pkg=
	local pkg_flag=
	local pkg_list=

	while [ "$#" -gt 0 ]; do
	case $1 in
		--archlinux)
			arch_flag=x
			[ -z "$pkg_list" ] || { arch_flag=o; pkg_flag=x; }
			;;
		--debian)
			debian_flag=x
			[ -z "$pkg_list" ] || { debian_flag=o; pkg_flag=x; }
			;;
		--fedora)
			fedora_flag=x
			[ -z "$pkg_list" ] || { fedora_flag=o; pkg_flag=x; }
			;;
		--gentoo)
			gentoo_flag=x
			[ -z "$pkg_list" ] || { gentoo_flag=o; pkg_flag=x; }
			;;
		--ubuntu)
			ubuntu_flag=x
			[ -z "$pkg_list" ] || { ubuntu_flag=o; pkg_flag=x; }
			;;
		--*)
			LOG_WARN "Unknown distro argument $1"
			;;
		*)
			pkg_list="$pkg_list $1"
			;;
	esac
	shift

	if [[ "$pkg_flag" == "x" ]] || [ "$#" -eq 0 ]; then
		[[ "$arch_flag" == "x" ]] && { arch_flag= ; arch_pkg="$pkg_list"; }
		[[ "$debian_flag" == "x" ]] && { debian_flag= ; debian_pkg="$pkg_list"; }
		[[ "$fedora_flag" == "x" ]] && { fedora_flag= ; fedora_pkg="$pkg_list"; }
		[[ "$gentoo_flag" == "x" ]] && { gentoo_flag= ; gentoo_pkg="$pkg_list"; }
		[[ "$ubuntu_flag" == "x" ]] && { ubuntu_flag= ; ubuntu_pkg="$pkg_list"; }

		pkg_list=
		pkg_flag=

		[[ "$arch_flag" == "o" ]] && arch_flag=x
		[[ "$debian_flag" == "o" ]] && debian_flag=x
		[[ "$fedora_flag" == "o" ]] && fedora_flag=x
		[[ "$gentoo_flag" == "o" ]] && gentoo_flag=x
		[[ "$ubuntu_flag" == "o" ]] && ubuntu_flag=x
	fi
	done
}

function PKG_REMOVE() {
}

