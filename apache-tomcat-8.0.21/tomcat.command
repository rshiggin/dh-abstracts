#!/bin/bash
echo ""
echo ""
echo "Welcome to the XTF workshop!"
echo ""
echo "Starting Tomcat..."
sleep 1
clear
export XTFWS=`/usr/bin/dirname "$0"`
export CATALINA_HOME="$XTFWS"
export XTF_HOME="$XTFWS/webapps/xtf"
cd "$XTFWS"
"$CATALINA_HOME/bin/catalina.sh" run
