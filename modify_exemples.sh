#i/bin/bash

mkdir dir1
touch dir1/file1
touch dir1/file2
mkdir dir1/dir2
touch dir1/dir2/file3
touch dir1/dir2/file4

touch file0

clear

ls -R1
echo ""
echo "Press any key for continue testing"
read pause

clear
echo "Recursively rename in uppercase a folder"
./modify.sh -ru dir1
ls -R1
echo ""
echo "Presse any kay to continue testing"
read pause

clear
echo "Recursively rename in lowercase a folder"
./modify.sh -rl DIR1/
ls -R1
echo ""
echo "Presse any key to continue testing"
read pause

clear
echo "Try to recursively rename in uppercase a file"
./modify.sh -ru file0
ls file0
echo ""
echo "Presse any key to continue testing"
read pause

clear
echo "Rename in uppercase a file"
./modify.sh -u file0
ls FILE0
echo ""
echo "Press any key to continue testing"
read pause

clear 
echo "Rename in lowercase a file"
./modify.sh -l FILE0
ls file0
echo ""
echo "Press any key to continue testing"
read pause

clear
echo "Trying to rename in lower case a file witch is already in lower case"
./modify.sh -l file0
ls file0
echo ""
echo "Press any key to continue testing"
read pause

clear
echo "Display help"
./modify.sh -h
echo ""
echo "Presse any key to continue testing"
read pause

clear
echo "Trying a wrong argument"
./modify.sh -f file0
echo ""
echo "Press any key to continue testing"
read pause

clear
echo "Trying to rename in uppercase or lowercase a file that doesn't exist"
./modify.sh -u vanish
echo ""
echo "Presse any key to finish"
read pause

rm -r dir1
rm file0
