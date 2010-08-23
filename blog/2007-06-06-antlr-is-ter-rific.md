---
title: "ANTLR is Ter-rific"
author: 'Bob McWhirter'
layout: blog
tags: [ blogging, java, jbossorg ]
---
Mark Proctor has <a title="Interview with Ter" href="http://markproctor.blogspot.com/2007/06/interview-with-antlr-30-author-terrence.html">posted an interview he did with Terence Parr</a> of ANTLR fame.  Ter is one of the nicest and smartest guys I know.

<img align="right" alt="Ter Parr" title="Ter Parr" src="/blog/assets/terence_antlr.jpg"/>Back in the day, teaching myself how to program in C++, I decided to write my own scripting language.  I'd tried (f)lex/yacc/bison, and they were either not friendly to C++, or not friendly to the way my brain works. Then I stumbled across <a title="PCCTS" href="http://www.polhode.com/pccts.html">PCCTS</a> and recursive-descent LL(k) parsers.  For once, the grammar productions seemed to make sense.  The generated code seemed to be readable and make sense.

Praise be unto Terence Parr, creator of PCCTS.

Then he abandoned C++ for Java, and created <a title="ANTLR.org" href="http://antlr.org/">ANTLR</a>.  Now it's up to version 3.0.  And <a title="The Definitive ANTLR Reference" href="http://www.pragmaticprogrammer.com/titles/tpantlr/">has a book</a>.

<a title="The Definitive ANTLR Reference" href="http://www.pragmaticprogrammer.com/titles/tpantlr/">
  <img width="132" height="146" align="left" style="border: 1px solid #cccccc; margin-right: 1em" alt="ANTLR Book" id="image269" title="ANTLR Book" src="/blog/assets/antlrbook.jpg"/>
</a>ANTLR is one of those libraries that you either love or have never heard about.  You've probably enjoyed the benefits of ANTLR none-the-less.
<ul>
	<li><a title="JBoss Rules grammar" href="http://fisheye.jboss.org/browse/JBossRules/trunk/drools-compiler/src/main/resources/org/drools/lang/DRL.g?r=12355">JBoss Rules rule language parsing</a></li>
	<li><a title="HQL grammar" href="http://fisheye.jboss.org/browse/Hibernate/trunk/Hibernate3/code/core/src/main/antlr/hql.g?r=11588">Hibernate HQL parsing</a></li>
	<li><a title="Groovy grammar" href="http://fisheye.codehaus.org/browse/groovy/trunk/groovy/groovy-core/src/main/org/codehaus/groovy/antlr/groovy.g?r=6505">Groovy language parsing </a></li>
</ul>
Being able to create a parser for a new little language (or "<a title="Domain-Specific Language" href="http://en.wikipedia.org/wiki/Domain_Specific_Language">DSL</a>" to be hip and trendy) opens up a whole world when implementing new software.  It makes it easy to think of formats beyond XML or CSV.  Users <a title="Humans should not have to grok XML" href="http://www.ibm.com/developerworks/xml/library/x-sbxml.html">get tired of being stabbed in the eye</a> with XML's pointy brackets.
