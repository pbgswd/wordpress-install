#!/bin/bash
# run this script with chmod 755 permissions.
#
#
workPath=$(pwd)

rm -rf filerepository repository www *.zip # this line cleans dir for testing, comment out when done

svnadmin create repository

mkdir -p filerepository/{branches,tags,trunk/{html,db,cron,scripts,themes,plugins,project,selenium}}
# got anything to import into those directories under trunk?
# import into the directories under trunk now
# before the next step
svn import filerepository file://$workPath/repository -m "initial import using getallwpsvn.sh script"
rm -rf filerepository
svn checkout file://$workPath/repository/trunk www
cd www
svn rm html
svn commit -m "rm html temporarily for clean propset"
svn propset svn:externals 'html http://core.svn.wordpress.org/trunk/' .
svn up
cd html/wp-content/
# get plugins from repository http://svn.wp-plugins.org/
# plugins listed in svn.plugins.externals
svn propset svn:externals -F ../../../svn.plugins.externals plugins/
#svn commit "plugins propset" # no commit if no local repository
svn up
# themes repository: http://svn.wp-themes.org/
# themes repository is a bit of a ghost town, none grabbed here
# browse the site and get the zip
# themes listed in svn.themes.externals file, if there are any
svn propset svn:externals -F svn.themes.externals plugins/
svn up

cd themes
# load up on themes
#more human readable format for array

THEMESITES[0]=http://dev.digitalnature.ro/fusion/fusion-wordpress.zip
THEMESITES[1]=http://ericulous.com/?load=googlechrome.zip
THEMESITES[2]=http://ericulous.com/?load=internetcenter.zip
THEMESITES[3]=http://ericulous.com/?load=redbusiness.zip
THEMESITES[4]=http://wordpress.org/extend/themes/download/elegant-box.4.1.1.zip
THEMESITES[5]=http://wordpress.org/extend/themes/download/thirtyseventyeight.4.0.zip
THEMESITES[6]=http://wordpress.org/extend/themes/download/thirtyseventyeight.4.0.zip
THEMESITES[7]=http://wordpress.org/extend/themes/download/constructor.0.6.4.zip
THEMESITES[8]=http://wordpress.org/extend/themes/download/jq.2.4.zip
THEMESITES[9]=http://wordpress.org/extend/themes/download/ahimsa.3.0.zip
THEMESITES[10]=http://wordpress.org/extend/themes/download/retromania.1.3.zip
THEMESITES[11]=http://wordpress.org/extend/themes/download/skinbu.1.0.3.zip
THEMESITES[12]=http://wordpress.org/extend/themes/download/mystique.1.16.zip
THEMESITES[13]=http://wordpress.org/extend/themes/download/lightword.1.9.3.zip
THEMESITES[14]=http://wordpress.org/extend/themes/download/monochrome.2.3.zip
THEMESITES[15]=http://wordpress.org/extend/themes/download/thematic.0.9.5.1.zip
THEMESITES[16]=http://wordpress.org/extend/themes/download/hybrid.0.6.1.zip
THEMESITES[17]=http://wordpress.org/extend/themes/download/new-york.1.0.1.zip
THEMESITES[18]=http://wordpress.org/extend/themes/download/f8-lite.1.3.zip
THEMESITES[19]=http://wordpress.org/extend/themes/download/simplex.1.3.1.zip
THEMESITES[20]=http://wordpress.org/extend/themes/download/cleanr.0.1.2.zip

for s in ${THEMESITES[@]}
do wget "$s"
done

FILES="*.zip"
for f in "$FILES"
do unzip "$f"
done

rm *.zip
rm *.zip.*
cd ../../../
svn commit -m "load in of plugins and themes complete"

cd $workPath
cp $workPath/www/html/wp-config-sample.php  $workPath/www/html/wp-config.php
chmod 777 $workPath/www/html/wp-config.php
chmod 777 $workPath/www/html/wp-content #temporarily, for cache
mkdir $workPath/www/html/wp-content/uploads && chmod 777 $_
touch $workPath/www/html/.htaccess && chmod 777 $_

# do any post processing, other importing now, and commit it if you did.
