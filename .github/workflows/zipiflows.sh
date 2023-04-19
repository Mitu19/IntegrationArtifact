#!/bin/bash

#git checkout irtsync
git diff --name-only --relative --diff-filter AMR HEAD^ HEAD ./ | grep MANIFEST.MF  | awk -F "/" '{print $1,$2}' > ../filetoProcess
cat ../filetoProcess

echo "before cycle:"
cat ../filetoProcess | while read line 
do
   # do something with $line here
    echo "line $line"
     ldirectory=$(echo $line | awk -F " " '{print $1 "'/'" $2}')
     echo "ldirectory $ldirectory"
     liflow=$(echo $line | awk -F " " '{print $2}')
     echo "liflow $liflow"
   
     cd $ldirectory/ ;
     echo "current $ldirectory:"
     ls -lrt
     if grep IntegrationFlow META-INF/MANIFEST.MF ; then
          zip -r ../../artifacts/$liflow.zip .
     fi
     cd ../../

done
