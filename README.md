# Group 38-7

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/3ee22fab026744149d197cc2b8633ca7)](https://app.codacy.com/gh/MaskedCarrot/Group38?utm_source=github.com&utm_medium=referral&utm_content=MaskedCarrot/Group38&utm_campaign=Badge_Grade)

![Java CI with Gradle](https://github.com/MaskedCarrot/Group38/workflows/Java%20CI%20with%20Gradle/badge.svg)

<h4> Ubuntu </h4>

 `sudo apt-get install git`


<h4>Windows</h4>
   <p>
Download git for windows from<a href="https://git-scm.com/downloads"> here</a> Install and then open git bash from start menu.
   </p>
  
  
<h5>Using git on Windows/Ubuntu</h5>
<ul>

<li> 

Fork the repo and copy the URL from code button then run `git clone <url>` if you have not cloned the repo.

</li>
<li>

`cd Group38`

</li>
<li>

`git checkout -b yourName` if branch not already created else use `git checkout yourName`</li>
<li> 

add or change files now</li>
<li>
 
 Run `git status` Now if you  see a few red lines. Run `git add <all red lines one by one>`
</li>
<li>

`git commit -m "Describe you change"`</li>
<li>

`git push origin yourName`</li>
</ul>

<ul>
 
 Then go to the forked repo of your github account and click on `create pull request`
 </ul>


Note : if you get this `*** Please tell me who you are.` message when you run `git push ` then read a little further and do what is says.


<h4> To update your repo </h4>

 `git remote add upstream https://github.com/MaskedCarrot/Group38.git`
 
  `git fetch upstream`
  
  `git checkout yourName`
  
  `git merge upstream/main`
  
