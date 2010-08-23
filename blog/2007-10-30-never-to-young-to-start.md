---
title: "Never to young to start?"
author: 'Bob McWhirter'
layout: blog
tags: [ asheville, family, lego ]
---
<img src="/blog/assets/picture-3.png" align="right" height="90" width="153"/>I volunteer each week at my son's school, where he's in a gifted class.  Lately, they've been working with Lego Mindstorms, as part of a unit on robotics.  I'm helping with the "programming" parts.  The kids assemble the robot according to the directions, and then we connect them to a Windows machine through the USB port.

The default programming environment is this drag'n'drop IDE where you connect blocks of actions, which can be parameterized.

If you want to see "agile development" in action, watch some 10-year-olds program robots.

They jump right in, drop in a block for a random-number generation, and then, um, they turn a light on, and move the robot forward a few seconds.  Notice, the random number is never used.  The kids just liked the look of that programming block.  It was orange, and looked pretty next to the green block to drive the motors.

It's agile, but with <a href="http://en.wikipedia.org/wiki/You_Ain't_Gonna_Need_It" title="YAGNI">YAGNI</a> reversed.  Who cares if they aren't going to need it?

Being a new-fangled "gifted" class, it's all about hands-on learning with very little pure instructional time.   I quite had to fight the urge to teach the kids about use-cases and requirements engineering.  I don't think you can even write unit tests in the visual Lego script.

They are only 10, after all, and it's Lego.

Of course, when you see ill-thought-out, buggy code in 15 years that has arbitrary un-used calls to <code>Random.nextInt()</code>, you can blame me, I guess.
