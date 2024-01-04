## TERMINAL COMMANDS
The terminal commands I used for this task respectively are:
for cloning the git hub repo: git clone < required git repo https >
to go to directory: cd path/to/directory
to view the files in the directory: ls
to copy files from one directory to another : cp path/to/the/file/ /path/to/the/file/you want to copy to
to check all branches : git branch -a
to select a branch : git checkout <required branch>
to copy file from different branch to another branch : git checkout <remote branch> <Relative path of the file to be copied from the other branch>
to access commit logs : git log
### To push changes from local machine using terminal
git add . or git add <whatever changed>
git status
git commit -m "text line"
git push origin main
since I've faced a difficulty in pushing as I made changes both locally and also online I had to merge everyhting so I used:
git pull (but didnt work saying diverging branches cant be fast forwarded)
so I used:
git merge --no-ff
![Screenshot_2024-01-04_22_42_43](https://github.com/ganidande905/amfoss-tasks/assets/142842955/a2bb7ae5-ae79-47e6-a59c-8d72f98bc79b)
