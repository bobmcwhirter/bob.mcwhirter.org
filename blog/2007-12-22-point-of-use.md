---
title: "Point of Use"
author: 'Bob McWhirter'
layout: blog
tags: [ dsl, java, languages, ruby ]
---
When we moved from C to C++, we were overjoyed that we no longer had to declare all of our variables at the top of the function.
<pre style="font-size: 10pt">
do_something() {
  int num = 0;
  int another_num = 0;
  num = get_a_num();
  another_num = get_a_num();
}</pre>
We could instead declare them near the point of use, when needed.
<pre style="font-size: 10pt">
do_something() {
  int num = 0;
  num = get_a_num();
  int another_num = 0;
  another_num = get_a_num();
}</pre>
Ultimately, the rule intends to make things visible to the smallest necessary scope.  While technically "scope" is an entire block, actual scope for a given statement consists only of that statement and those that follow.  Defining variables at the top of a block unnecessarily extends their scope beyond the actual needs.

That's great for variables.  What about expressions or statements or blocks of statements?

When we hack out straight code, perhaps a one-time chunk of Perl or Ruby or bash, we declare a statement exactly at its point of use.   If we don't name it, it's lost in the ether, immediately out of scope again.
<pre style="font-size: 10pt">
rm -Rf path/to/stuff
mkdir other/path/to/stuff
cc -o google google.c</pre>
We climb up into the world of "engineering" and we start to create functions, or classes and methods.  We give names to a chunk of statements and increase the visible scope of this code.
<pre style="font-size: 10pt">
def turn_on_sprinkler()
  call_sprinkler_webservice( :on )
end</pre>
But have we just moved our declarations too high, like our variable declarations in C at the top of the block?

We follow a rule that if you use the result of an expression more than once, you should stuff it into a variable.  A local variable.  Not a global variable.  More than likely not an instance variable.

How about if you use a statement more than once, you stuff it into a named block.  A local named block.  Not a global named block.  More than likely not a method on a class.
<pre style="font-size: 10pt">
notify = Proc.new{|person,message|
  person.email.send( message )
  person.sms.send( message )
}

notify.call( person.wife, "I'll be home late" )
notify.call( person.mistress, "Motel 6 in 10" )</pre>
Unless the functionality is required at any higher scope, declaring and defining named blocks locally prevents pollution of the namespaces.

With languages such as Ruby, instance methods can be defined upon instances that need them, instead of upon every instance of a given class.
<pre style="font-size: 9pt">
def ship_via_cargo_container(item={})
  class &lt;&lt; item
    def cube
      (self[:height]||1) * (self[:width]||1) * (self[:length]||1)
    end
  end

  freight_cost  = item.cube * 100.dollars
  handling_cost = item.cube * 10.dollars * 2
end</pre>
In effect, this view is one of macros.  When it's convenient to create a short-hand notation, or a micro-DSL, do it where it has minimal impact on the rest of the system.

It could be argued that interpreters and compilers are not prepared to see and optimize for these types of blocks.  The Java world surely keeps debating closures.  I have no idea the impact on Ruby interpretation when you're constantly defining new methods on individual objects.  But then again, there was a time we feared the overhead of managing objects instead of simply free functions and structs.
