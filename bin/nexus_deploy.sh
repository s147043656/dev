#!/bin/bash

if [ $# -lt 2 ]; then
    echo -e "\n\tUsage:\tnexus_deploy.sh appname snapshot|release\n"
    exit 1
fi

bin_dir=`dirname $0`
cd $bin_dir

appname=$1
packagetype=$2
nexusrepo=http://nexus.u1204.vtdomain/nexus/content/repositories/${appname}-app-${packagetype}s

# Set package path

if [ ${appname} == entrain ]; then
    packagepath=com/vtdomain/entrain
fi
if [ ${appname} == hotel ]; then
    packagepath=com/javaworld/hotels/HotelWebapp
fi

# Download and collect package meta information

wget -O maven-metadata.xml "${nexusrepo}/${packagepath}/maven-metadata.xml"
packageversion=`grep "<version>" maven-metadata.xml | uniq | sed 's/\ *<*\/*version>//g'`
wget -O maven-metadata.xml "${nexusrepo}/${packagepath}/${packageversion}/maven-metadata.xml"
lastversion=`grep value maven-metadata.xml | uniq | sed 's/\ *<*\/*value>//g'`
packagename=`grep artifactId maven-metadata.xml | uniq | sed 's/\ *<*\/*artifactId>//g'`
packageext=`grep extension maven-metadata.xml | grep -v "pom" | uniq | sed 's/\ *<*\/*extension>//g'`
tpfilename=${packagename}.${packageext}
rm -rf maven-metadata.xml

# Debug info

echo -e "\tappname: ${appname}"
echo -e "\tpackagetype: ${packagetype}"
echo -e "\texusrepo: ${nexusrepo}"
echo -e "\tpackagepath: ${packagepath}"
echo -e "\tpackageversion: ${packageversion}"
echo -e "\tlastversion: ${lastversion}"
echo -e "\tpackagename: ${packagename}"
echo -e "\tpackageext: ${packageext}"
echo -e "\tpfilename: ${tpfilename}\n"

# Dwonload artifact

wget -O ${tpfilename} ${nexusrepo}/${packagepath}/${packageversion}/${packagename}-${lastversion}.${packageext}

# Deploy

/bin/bash tomcat_deploy.sh $appname ${tpfilename}

rm -rf ${tpfilename}
