#!/usr/bin/env bash
. /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
USER_NAME=$1
USER_PWD=$2
IMPORT_DIR=$3
DUMP_FILE=$4
/u01/app/oracle/product/11.2.0/xe/bin/sqlplus system/oracle@localhost  <<EOF
CREATE USER $USER_NAME IDENTIFIED BY "$USER_PWD";
GRANT connect, create procedure, create table, alter session, dba, create session to $USER_NAME;
EOF
/u01/app/oracle/product/11.2.0/xe/bin/sqlplus $USER_NAME/$USER_PWD  <<EOF
create or replace directory import_dp as '$IMPORT_DIR';
EOF
impdp $USER_NAME/$USER_PWD directory=import_dp dumpfile=$DUMP_FILE