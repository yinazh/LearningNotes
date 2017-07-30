# Learning Github Operations

## github config operations:

(1) please config your name and your email

$git config --global user.email "xxx"

$git config --global user.email "xxx"

(2) config your sshkey to github

$ssh-keygen -t rsa -C "xxx@xxx.cn"

then still enter,finsih, you can find sshkey in ~/.ssh/id_ras.pub

please add your id_rsa.pub key to your github ssh key profile

(3) then test:

$ssh -T git@"your github ip address"

then you can submit your code 

## submit your code 

$git clone https://github.com/yinazh/hello-world.git

$cd hello-world

$git status 

$vim README.md

$git add .

$git commit -m "update README.md"

$git push -u origin master

$git branch newbranch

$git checkout newbranch

modify README.md

$git add README.md

$git commit -m "update README.md"

$git push origin master

$git merge yinazh master

$git push origin yinazh:master
