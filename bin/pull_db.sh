#!/bin/bash
# pull_db
#
# Utility script for copying tables from one MySQL DB to another
#
# pull_db -h for usage.
#
# Copyright (C) 2017-2018 Aaron Wallentine <aaron@adubsvc.net>
# Distributed under the GNU General Public License, version 2.0.
#
#

function main {

    set_defaults
    get_args "$@"


    source_host_arg="-h ${source_host}"
    source_port_arg="-P ${source_port}"

    source_user_arg="";
    if [ "$source_user" != false ]; then
        source_user_arg="-u ${source_user}"
    fi

    dest_port_arg="-P ${dest_port}"

    if [ "$dest_host" != "localhost" ]; then
        dest_host_arg="-h ${dest_host}"
    fi

    dest_user_arg=""
    if [ "$dest_user" != false ]; then
        dest_user_arg="-u ${dest_user}"
    fi

    mkdir -p ${dump_dir}

    timestamp=`date +%F_%H.%M.%S_%Z`;

    for table_name in "${source_tables[@]}"
    do
        source_tables_str+="$table_name""__"
    done

    dump_filename="${dump_dir}/${source_db}__${source_tables_str}_${timestamp}_dump.sql"

    for table_name in "${exclude_tables[@]}"
    do
        exclude_tables_arg+=" --ignore-table=${source_db}.${table_name} "
    done

    echo
    echo "Dumping to ${dump_filename} ..."
    #set -vx
    mysqldump -v ${nodata_arg} ${source_host_arg} ${source_port_arg} ${source_user_arg} $source_password_arg ${source_db} ${source_tables[*]} ${exclude_tables_arg} > ${dump_filename}
    mysqldump_success=$?
    #set +vx

    if [ "${mysqldump_success}" != 0 ]; then
        echo; echo "Error encountered in dumping from source db; aborting."
        exit 1;
    fi


    echo
    echo "Importing to ${dest_db} ..."
    #set -x
    mysql ${dest_host_arg} ${dest_port_arg} ${dest_user_arg} ${dest_password_arg} ${dest_db} < ${dump_filename}
    #set +x
    echo "Done."

}


function set_defaults {

    source_db="source_db"

    dest_host="localhost"
    dest_port=3306
    dest_user=false
    dest_password_arg=''

    source_host="localhost"
    source_port=3306
    source_user=false

    dest_db="dest_db"
    dump_dir="./pull_db_dumps"

    # load config to get anything that will override defaults above
    # todo:2018-02-27:aaronw: add support for 'no data' (structure only) option in config?
    load_config

    source_password_arg=''
    if [ "${source_password}" != "" ]; then
        source_password_arg="--password=${source_password}"
    fi

    dest_password_arg=''
    if [ "${dest_password}" != "" ]; then
        dest_password_arg="--password=${dest_password}"
    fi

    nodata_arg=''  # the -d flag to mysqldump will dump structure only, no data

}



function load_config {

    config_file_name=".pull_db.conf.sh"
    script_dir=$(dirname "$(readlink -f "$0")")

    files_to_try=( "${script_dir}/${config_file_name}" # first, config file in script dir as global config
                   "${HOME}/${config_file_name}"       # next, config file in home dir as userwide config
                   "`pwd`/${config_file_name}" )       # then, config file in working dir as local config

    # todo:2018-03-23:aaronw: maybe keep a list of which config files have been loaded, and don't re-output (or re-load) if already loaded.  As it is, if the working dir is the same as either the home dir or the script dir, it will output that it has loaded the file more than once.  Alternatively, could check if pwd (and home dir) is same before adding to files_to_try array ...
    for file_to_try in "${files_to_try[@]}"; do
        if [ -f "${file_to_try}" ]; then
            source "${file_to_try}"
            echo "Loaded config file at '${file_to_try}'."
        fi
    done
}



function get_args {
    if [ $# -eq 0 ]; then # if no args
        print_usage
        exit 1
    fi

    OPTIND=1 # A POSIX var, reset in case getopts has been used previously in the shell.

    while (( $# )); do
        case "$1" in
        -h|-\?|--help ) print_usage;;
        -i ) get_args_interactively;;
        # the 'shift 2' is required for parameters with values because they
        # technically have 2 parameters
        -sh ) source_host=$2; shift 2;;
        -sP ) source_port=$2; shift 2;;
        -su ) source_user=$2; shift 2;;
        -spp ) source_password_arg="-p"; shift 1;;
        -sp ) source_password_arg="--password=${2}"; shift 2;;
        -sd ) source_db=$2; shift 2;;
        -st )
            # todo: factor out and encapsulate this repeated logic for building an array from multi-value args so it can be reused elsewhere
            source_tables+=($2);
            shift 2;
            # assign any more words in this arg to it
            while (( $# )); do
                case "$1" in
                -* ) break  ;;
                * ) source_tables+=($1) ;;
                esac
                shift 1
            done
            echo "source tables: ${source_tables[*]}";
            ;;
        -et )
            # todo: factor out and encapsulate this repeated logic for building an array from multi-value args so it can be reused elsewhere
            exclude_tables+=($2);
            shift 2;
            while (( $# )); do
                case "$1" in
                -* ) break ;;
                * ) exclude_tables+=($1) ;;
                esac
                shift 1
            done
            echo "Excluding tables: ${exclude_tables[*]}";
            ;;
        -dh ) dest_host=$2; shift 2;;
        -dP ) dest_port=$2; shift 2;;
        -du ) dest_user=$2; shift 2;;
        -dpp ) dest_password_arg="-p"; shift 1;;
        -dp ) dest_password_arg="--password=${2}"; shift 2;;
        -dd ) dest_db=$2; shift 2;;
        -nd ) nodata_arg="--no-data"; shift 1;;
        -- ) shift; break ;;
        * )  shift ;;
        esac
    done
}


function print_usage {
    echo
    echo "Dump database or table from source DB and import into destination DB. ";
    echo
    echo "Args: ";
    echo "       -h, -?         : show this help message";
    echo "       -i             : interactive mode (still in development)";
    echo "       -sh <host>     : Source host (default 'localhost')";
    echo "       -sP <port>     : Source port (default 3306)";
    echo "       -su <user>     : Source username (default current user)";
    echo "       -spp           : Prompt for source password";
    echo "       -sp <password> : Source password";
    echo "       -sd <db>       : Source database (default 'source_db')";
    echo "       -st <table1> [<table2>] ...
                                : Source table(s) (separated by spaces).";
    echo "                        If no table specified, grabs all tables.";
    echo "       -et <table1> [<table2>] ...";
    echo "                      : Exclude table(s) (separated by spaces)."
    echo "       -dh            : Destination host (default 'localhost')";
    echo "       -dP            : Destination port (defaults to 3306)";
    echo "       -du            : Destination username";
    echo "       -dpp           : Prompt for destination password";
    echo "       -dp <password> : Destination password";
    echo "       -dd <db>       : Destination DB (default 'dest_db')";
    echo;
    echo "       -nd            : Dump/import structure only, no data";
    echo
    echo "Creating a '.pull_db.conf.sh' in script dir, home dir, or working dir can be used to set defaults.  Will be applied in that order."
    echo "a '.pull_db.example.conf.sh' should have been distributed with this script to show available options; copy and override as desired."

    exit 0
}







function get_args_interactively {
    echo "Interactive mode -- ";
    get_input source_host 'Source host?' $source_host
    get_input source_port 'Source port?' $source_port
    get_input source_user 'Source username?' $source_user
    get_input source_password 'Source password?' $source_password
    exit
}



# $1 : string; return var name
# $2 : string; prompt
# $3 : string; default value
function get_input {
    declare -n input=$1
    local prompt=$2
    local default=$3
    read -p "${prompt} (${default}): " input
    if [ -z $input ]; then
        input=$default
    fi
    echo "  will be '${input}'."
}




main "$@"
