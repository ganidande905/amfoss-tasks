## TERMINAL COMMANDS
The terminal commands I used for this task respectively are: <br>
for cloning the git hub repo: git clone < required git repo https ><br>
to go to directory: cd path/to/directory<br>
to view the files in the directory: ls<br>
to copy files from one directory to another : cp path/to/the/file/ /path/to/the/file/you want to copy to<br>
to check all branches : git branch -a<br>
to select a branch : git checkout <required branch><br>
to copy file from different branch to another branch : git checkout <remote branch> <Relative path of the file to be copied from the other branch><br>
to access commit logs : git log<br>
### To push changes from local machine using terminal<br>
git add . or git add <whatever changed><br>
git status<br>
git commit -m "text line"<br>
git push origin main<br>
since I've faced a difficulty in pushing as I made changes both locally and also online I had to merge everyhting so I used:<br>
git pull (but didnt work saying diverging branches cant be fast forwarded)<br>
so I used:<br>
git merge --no-ff<br>
![Screenshot_2024-01-04_22_42_43](https://github.com/ganidande905/amfoss-tasks/assets/142842955/a2bb7ae5-ae79-47e6-a59c-8d72f98bc79b)
