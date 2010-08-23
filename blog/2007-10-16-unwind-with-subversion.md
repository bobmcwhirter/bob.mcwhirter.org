---
title: "Unwind with Subversion"
author: 'Bob McWhirter'
layout: blog
tags: [ codehaus, jbossorg, opensource, ruby, subversion, tools ]
---
At the <a title="Codehaus" href="http://codehaus.org/">Codehaus</a> and at <a title="JBoss" href="http://jboss.org/">JBoss.org</a>, I've continually come across Subversion repositories that needed to be split apart or merged, perhaps after converting from CVS.  One problem you continually hit, particularly if you're merging repositories, is <a href="http://svn.haxx.se/dev/archive-2006-01/0381.shtml">the "date order of revisions" bug</a>.  Simply stated, if you create a new repository loaded from two other repositories, you can end up with a situation where revision N does not necessarily occur before revision N+1, in terms of the commit time-stamp.

When you do a date-based operation using Subversion, it does a binary search through the revision sequence to find the revisions matching the specified dates. This binary search assumes the revisions are indeed date-ordered.

With the acquisition of Mobicents by JBoss, we're in the situation of having to merge about a dozen repositories. Some are CVS, some are SVN.  Good ol' <a title="cvs2svn" href="http://cvs2svn.tigris.org/cvs2svn.html">cvs2svn</a> works well for the first step, of converting a CVS repository into a SVN repository.  But now we have either oddly disjoint repositories, or conflicting paths overlaid one another.

I've always been a fan of <a title="mod_rewrite beginners guide" href="http://www.workingwith.me.uk/articles/scripting/mod_rewrite">mod_rewrite</a> for <a title="Apache httpd" href="http://httpd.apache.org/">Apache-httpd</a>, and a <a title="SVN dumpfile format" href="http://svn.collab.net/repos/svn/trunk/notes/dump-load-format.txt">SVN dumpfile</a> has a lot of paths just ripe for rewriting.  1000 lines of Ruby code later, I'm able to announce <a title="Unwind" href="http://svn.rubyhaus.org/unwind/trunk/">Unwind</a>.  Unwind is a Ruby library, along with a command-line tool, for performing mind-numbing feats of repository surgery.

Since a massive conversion and rewriting is something that requires a bit of trial-and-error, the command-line utility is ultimately driven by a configuration file.  Of course, with Ruby, it's just a DSL created using <a title="Ruby instance_eval" href="http://www.ruby-doc.org/core/classes/Object.html#M000336">instance_eval</a> and blocks.

<img width="461" height="389" id="image327" alt="Picture 5.png" src="/blog/assets/Picture%205.png"/>

This configuration file will ultimate produce a single file (<code>merged-repo.svndump</code>) from multiple input dump files.  Each source file can <code>include()/exclude</code> paths (based upon the original paths in that particular dumpfile).  Each source can also use Rails-ish URL rewriting.  The <strong>
  <code>:something</code>
</strong> syntax matches 1 segment of a path, and is available as a substitution value in the output path for the rule.

The rewrite engine tracks all existing paths, and creates parent directories when necessary.  SVN <strong>
  <code>copy</code>
</strong> operations are fully adjusted both for the source and the destination paths.

Unwind automatically interleaves revisions to achieve total monotonically increasing time-ordering for the final repository.

Finally, before a revision is emitted to the output repository, addition <code>include()/exclude()</code> rules can be applied.  For repositories converted from CVS, you may end up with a bundle of <code>CVSROOT</code> directories attempting to live in the same location.  No reason to rewrite them to unique locations, as you can just exclude them before they get figured into the final output repository.

Unwind uses <a title="SQLite" href="http://www.sqlite.org/">SQLite</a> for organizing the meta-information about each repository and revision, while performing random-access seeks on the source dumpfiles to produce the final repository.   While merging may be the common use-case, Unwind's rewriting also makes it useful just for extracting bits out of a repository.

At this point, this blog entry is the complete documentation for Unwind.  But feel free to <a title="Unwind repository" href="http://svn.rubyhaus.org/unwind/trunk/">browse the SVN repository</a>.
