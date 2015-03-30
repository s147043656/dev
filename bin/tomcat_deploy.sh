#!/bin/bash

if [ $# -lt 1 ]; then
    echo -e "\n\tUsage:\ttomcat_deploy appname\n"
    exit 1
fi

bin_dir=`dirname $0`
cd $bin_dir
appname=$1
tpfilename=$2
configs_dir=configs/deployment

if [ -f ../${configs_dir}/${appname} ]; then
    . ../${configs_dir}/${appname}
else
    echo -e "\n\tFile ../${configs_dir}/appname not found.\n"
    exit 1
fi

if [ -z ${tpfilename} ]; then
    tpfilename=`ls ${dist_dir} | grep war`
    if [ -z ${tpfilename} ]; then
    echo -e "\t\nERROR:\tDeployment artifact is not defined."
    exit 1
    fi
    tpfilename=${dist_dir}/${tpfilename}
    echo -e "\t\nDeployment artifact is not defined, will be used ${tpfilename}\n"
fi

${tomcat_dir}/bin/shutdown.sh
rm -rf ${tomcat_dir}/conf/Catalina
rm -rf ${tomcat_dir}/work/Catalina
rm -rf ${tomcat_dir}/temp/*
rm -rf ${tomcat_dir}/webapps/${appname}
rm -rf ${tomcat_dir}/webapps/${appname}.war
rm -rf ${tomcat_dir}/logs/*

echo -e "\n\tApplication ${appname} will be deployed to tomcat server in directory ${tomcat_dir}\n"
cp  ${tpfilename} $tomcat_dir/webapps/${appname}.war
${tomcat_dir}/bin/startup.sh
