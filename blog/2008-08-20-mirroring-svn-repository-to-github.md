---
title: "Mirroring SVN repository to GitHub"
author: 'Bob McWhirter'
layout: blog
tags: [ git, java, jruby, subversion ]
---
So, I'm gearing up to work on some Java+Ruby (via JRuby) stuff.  The Java world still seems fairly entrenched in the cult of Subversion, while the Rubyists have gone with <a title="Git" href="http://git.or.cz/">Git</a> lately.

I'm still wrapping my mind around Git, but with <a title="GitHub" href="https://github.com/">GitHub</a>, it's fairly easy and straight-forward.  I paid my $7 for the micro account, to give me room to screw around.

There's quite a few posts about mirroring SVN to a Git repository, but I feel the need to add my own, of course.

My goal is mirror the trunk of the JRuby project from Codehaus SVN to my account on GitHub.  By doing this, I can track the trunk development, and also work on my own patches.

I started by creating an empty repository on my GitHub account, called 'jruby'.
<blockquote>
  <a title="My JRuby Git repository" href="http://github.com/bobmcwhirter/jruby/tree/master">http://github.com/bobmcwhirter/jruby/tree/master</a>
</blockquote>
Now, over on my always-on, Contegix-powered server, I create a brand new local git repository, also called jruby.
<blockquote>mkdir jruby

cd jruby

git init</blockquote>
Next I use 'git svn init' to setup the SVN repository as a remote code source to track.  Using the -T switch points git to the trunk, and ignores branches and tags, which is fine for my purposes.
<blockquote>git svn init -T <a title="JRuby svn repository" href="http://svn.codehaus.org/jruby/trunk/jruby/">http://svn.codehaus.org/jruby/trunk/jruby/</a></blockquote>
That does not pull any code, but it lets my local working tree know that I'm going to be pulling from an SVN repository at some point.  This setup only occurs in your local repository, and does not seem to ever get pushed to GitHub once we get to that point.

So, now we do the initial pull.  Once again, this is on my always-on, Contegix-powered server, not my local laptop.  I'm doing this on a server because towards the end, we'll be setting up a cronjob to accomplish it all.
<blockquote>git svn fetch</blockquote>
It'll think for a while, it'll slurp down the SVN revision history, it'll stop and ponder occasionally, and eventually, it'll be done.  Woo-hoo!  Our local working tree is now up-to-date with the subversion HEAD as of that moment.

To reduce disk-space used by your local repository, go ahead and run the garbage collector
<blockquote>git gc</blockquote>
On my system, that reduced the space from over 600mb to under 70mb.

Now, that's great, but it's still just on my local repository.  Time to push it to GitHub.  We're not going to follow their directions exactly, since this will ultimately be a cronjob and needs to use ssh.  And I'm slightly paranoid about my ssh keys.

So, the first thing I do is create another keypair, for used only by my mirroring process, and only for pushing changes to github.  It has no passphrase.  This allows me to keep my top-secret keys off my shared, always-on server.  If these keys are compromised, all an attacker can use them for is to push changes to GitHub.  Which, being revision-control, is more annoying than dangerous.  (Hooray for "git reset").
<blockquote>ssh-keygen -t dsa -f .ssh/id_dsa_github_mirroring</blockquote>
Next, I edit my .ssh/config to add a "fake host" so that ssh connections invoked by git will use this new key.

As with all previous bits, this is still on my always-on server, not my local laptop.
<blockquote>Host githubmirror
User git
Hostname github.com
IdentityFile /home/bob/.ssh/id_dsa_github_mirroring</blockquote>
This will cause any invocation of "ssh githubmirror" into "ssh git@github.com -i .ssh/id_dsa_github_mirroring".

I then installed id_dsa_github_mirroring.pub into my GitHub account.

Now, GitHub's instructions say to run this command to add the GitHub repository as a remote named "origin"
<blockquote>git remote add origin git@github.com:bobmcwhirter/jruby.git</blockquote>
Instead, we teak it to use the "fake host" we added to .ssh/config
<blockquote>git remote add origin git@githubmirror:bobmcwhirter/jruby.git</blockquote>
We're almost done, I promise.

Next, we need to do the first push from my server up to GitHub.  We first push to the 'master' branch, since the repo really wants to have a master branch.
<blockquote>git push origin master</blockquote>
Now, GitHub doesn't allow you to fork a repository you own, and since this mirror is owned by me, where can I do my own hacks and patches?  The 'master' branch of course.  But I still want an unmolested, straight-from-subversion mirror.  So, I create a 'vendor' branch in my workspace.  It's initialized to match 'master' exactly.
<blockquote>git checkout -b vendor</blockquote>
Now, I push that to GitHub, too.
<blockquote>git push origin vendor</blockquote>
Awesome.  I now have two branches, identical at the moment, called "vendor" and "master".

Now, as far as I can tell, all the Subversion setup that we did only lives in the local repository on my always-on server.  Anyone who clones from the GitHub repository will not have that stuff.  They can of course do a 'git svn init' themselves, to add it to their local repository.  But it doesn't flow through GitHub.

But that's fine, since I've been doing this on my always-on server anyhow.  My workspace is sitting in the 'vendor' branch that's tracking the vendor branch from github.

I can pull the latest changes from Subversion by typing
<blockquote>git svn rebase</blockquote>
The 'rebase' command is neat, in that any changes that exist in the git repository are floated to be applied to whatever the latest HEAD is.  But since I'm only concerned with a one-way SVN-to-Git mirror, there will never be any changes to float, and this will just tack on subsequent SVN commits as Git commits onto the 'vendor' branch.  It'll leave the 'master' branch un-touched.

After rebasing, you gotta push the 'vendor' branch up to GitHub.
<blockquote>git push origin vendor</blockquote>
Now, type that every 15 minutes, and your 'vendor' branch will stay mostly up-to-date.

Or use cron.

I've cronned a script that fires every 15 minutes
<blockquote>#!/bin/sh

cd /home/bob/github-svn-mirrors/$1
git svn rebase
git push origin vendor</blockquote>
It's run with the repository name as the first (and only) argument
<blockquote>*/15 * * * * /home/bob/github-svn-mirrors/bin/mirror jruby</blockquote>
Now, over on my laptop, finally, I can clone the repository, work on topic branches, push to master and have my own controlled environment and fork, while knowing the 'vendor' branch reflects the pure SVN state which I can also pull into my hackings as-desired.

When I submit a patch, if it ultimately floats back to me through the vendor branch, git is supposedly smart enough to realize that the same changes have arrived in my 'master' (assuming it's applied verbatim) and keep things nice and tidy.  Else, I can force a merge, trampling my half-assed patch with the official JRuby code.
