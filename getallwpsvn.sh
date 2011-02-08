#!/bin/bash
# set this script permissions to 755. 'chmod 755 getallwpsvn.sh'.
# run from the command line with './getallwpsvn.sh'.
# nosvn branch, see http://github.com/superwebdeveloper/wordpress-install/tree/nosvn
# create a wordpress website with themes and plugins without making local svn repository in the process
#
# Define your work path in one of the following 2 ways. 
# When this script is in the web root, use workPath=$(pwd)
# When you are just going to run the script elsewhere, point to the directory above the web root
# Watch screen output for errors. Wipe, tweak and run again.
#

#workPath=$(pwd)
workPath=

#set to your what your web root is, html, public_html, www etc
webDir=$workPath/html

cd $webDir
pwd 

svn export --force 'http://core.svn.wordpress.org/trunk/' . 

cd wp-content/plugins/
pwd
# get plugins from repository http://svn.wp-plugins.org/

svn export http://svn.wp-plugins.org/all-in-one-seo-pack/trunk all-in-one-seo-pack
svn export http://svn.wp-plugins.org/advertising-manager/trunk advertising-manager
svn export http://svn.wp-plugins.org/google-sitemap-generator/trunk google-sitemap-generator
svn export http://svn.wp-plugins.org/feedburner-plugin/trunk fd-feedburner
svn export http://svn.wp-plugins.org/feed2tweet/trunk feed2tweet
svn export http://svn.wp-plugins.org/sociable/trunk sociable
svn export http://svn.wp-plugins.org/stats/trunk stats 
svn export http://svn.wp-plugins.org/ultimate-google-analytics/trunk ultimate-google-analytics 
svn export http://svn.wp-plugins.org/vipers-video-quicktags/trunk vipers-video-quicktags
svn export http://svn.wp-plugins.org/share-on-facebook/trunk share-on-facebook
svn export http://svn.wp-plugins.org/twitter-widget-pro/trunk twitter-widget-pro
svn export http://svn.wp-plugins.org/wordbook/trunk wordbook 
svn export http://svn.wp-plugins.org/wp-flickr/trunk wp-flickr 
svn export http://svn.wp-plugins.org/wp-super-cache/trunk wp-super-cache 
svn export http://svn.wp-plugins.org/multi-level-navigation-plugin/trunk multi-level-navigation-plugin
svn export http://svn.wp-plugins.org/xrds-simple/trunk xrds-simple
svn export http://svn.wp-plugins.org/openid/trunk openid
svn export http://svn.wp-plugins.org/insere-iframe/trunk/ insere-iframe
svn export http://svn.wp-plugins.org/redirect-by-custom-field/trunk/ redirect-by-custom-field
svn export http://svn.wp-plugins.org/wp-email/trunk/ wp-email
svn export http://svn.wp-plugins.org/wp-email-capture/trunk/ wp-email-capture
svn export http://svn.wp-plugins.org/wp-responder-email-autoresponder-and-newsletter-plugin/trunk/ wp-responder-email-autoresponder-and-newsletter-plugin

PLUGINS[0]=http://www.deliciousdays.com/wp-content/themes/dd/c3.php?http://www.deliciousdays.com/download/cforms-v11.7.2.zip
for s in ${PLUGINS[@]}
do wget "$s"
done

FILES="*.zip"
for f in "$FILES"
do unzip "$f"
done

rm *.zip
rm *.zip.*

# get cforms manually, etc
# 
cd ../themes
pwd
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
THEMESITES[21]=http://wordpress.org/extend/themes/download/cleanr.0.1.2.zip
THEMESITES[22]=http://wordpress.org/extend/themes/download/arras-theme.1.5.0.1.zip
THEMESITES[23]=http://wordpress.org/extend/themes/download/patagonia.1.6.6.zip
THEMESITES[24]=http://wordpress.org/extend/themes/download/graphene.1.1.3.1.zip
THEMESITES[25]=http://wordpress.org/extend/themes/download/custom-community.1.6.2.zip
THEMESITES[26]=http://wordpress.org/extend/themes/download/swift.5.54.zip


 
for s in ${THEMESITES[@]}
do wget "$s"
done
 
FILES="*.zip"
for f in "$FILES"
do unzip "$f"
done
 
rm *.zip
rm *.zip.*

cd $webDir
cp $webDir/wp-config-sample.php $webDir/wp-config.php
chmod 777 $webDir/wp-config.php
chmod 777 $webDir/wp-content #temporarily, for cache

mkdir $webDir/wp-content/uploads && chmod 777 $_
touch $webDir/.htaccess && chmod 777 $_
echo "done importing wordpress core, plugins, and themes. Go make your db, manually configure wp-config.php, and perform setup."
 
# do any post processing, other importing now, and commit it if you did.