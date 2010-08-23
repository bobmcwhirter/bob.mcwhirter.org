---
title: "Be a smarter patch monkey"
author: 'Bob McWhirter'
layout: blog
tags: [ git, metaprogramming, ruby ]
---
A project I'm working on requires some hard-core monkey-patching of Rails internals.

Monkey-patching is a dangerous occupation, and liable to cause new and intriguing bugs into previously-tested sane code.

I've been working on a smarter patch-monkey, known as <a title="Lemur: The smarter patch monkey" href="http://github.com/bobmcwhirter/lemur/tree/master">Lemur</a>.

The goal is to allow monkey-patched methods (currently only instance methods are supported) to be written in modules that are mixed in (as modules are) but allowing redefinition of methods in the patchee by the patcher module.

I may be ignorant of some Ruby to make it happen, but I've resorted to <strong>alias_method</strong> and <strong>remove_method</strong>, along with a handful of Ruby's reflection methods to swap methods in a reasonable, clean, and auditable fashion.

The specs demonstrate how it works.  Assume a basic class:
<pre>
  <code>
class BasicClass
  def some_instance_method()
    # ...
  end
end
</code>
</pre>
And a module to monkey-patch it
<pre>
  <code>
module PatchModule
  def some_instance_method()
    # ...
  end
end</code>
</pre>
Normally, Ruby will prefer a locally-defined method over a module mix-in, so you can't just <strong>include</strong> your patch module in, even using <strong>class_eval</strong>.

So, invite in the Lemur.
<pre>
  <code>
Lemur.patch_class(BasicClass, PatchModule)
</code>
</pre>
And voila!  Your class is monkey-patched by the nicely self-contained module,  plus, it's tracked.
<pre>
  <code>
Lemur.patched_classes # [ BasicClass ]
</code>
</pre>
And even more cool, you can get some patch-audit information for each patched class:
<pre>
  <code>
Lemur.patch_records( BasicClass ) # [ array of PatchRecords ]
</code>
</pre>
Each PatchRecord keeps up with the patched class, the patched method name, the actual replaced Method object, along with the patch module and the patch method.

A total of 40min has been spent writing the code so far.  The idea is to add better auditability, <strong>unpatching</strong>, and dealing with class methods, not just instance methods.

Now, when you encounter a weird bug, you can ask the Lemur where the oddness might've originated.

Want to pitch in and do some meta-programming to make future meta-programming less scary, <a href="http://github.com/bobmcwhirter/lemur/tree/master">fork my git repository</a> and send me some pull requests.
