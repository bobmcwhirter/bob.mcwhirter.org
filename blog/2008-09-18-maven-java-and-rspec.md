---
title: "Maven, Java and RSpec"
author: 'Bob McWhirter'
layout: blog
tags: [ java, junit, maven, rspec, testing ]
---
Since I've been back on the job, writing Java code lately, that means I've been testing Java code lately.

After living in the land of Ruby with <a title="RSpec" href="http://rspec.info/">RSpec</a>, thinking about JUnit did not excite me.  Thankfully I found the <a title="rspec-maven-plugin" href="http://svn.codehaus.org/mojo/trunk/sandbox/rspec-maven-plugin/">rspec-maven-plugin</a>, which integrates straight into the maven test process.

I like rspec because it removes a whole lot of the cruft involved in writing tests.  When I return to the specs weeks later, I can still read the intent.  So often, with JUnit tests named with cryptic method names, it's difficult to ascertain exactly what's intended to be tested.

The beta-4 plugin on the repository is based on jruby-1.1.2, but in SVN I've updated it to support 1.1.4.  I think there's still some more improvements to be made, such as respecting <strong>maven.test.skip</strong> and getting rid of the need for <strong>JRUBY_HOME</strong> pointing to a full installation. (Note: I did not write this plugin, I've just started contributing to it).

After a little configuration of the plugin in your pom.xml...
<pre>
  <code>
&lt;plugin&gt;
  &lt;groupId&gt;org.codehaus.mojo&lt;/groupId&gt;
  &lt;artifactId&gt;rspec-maven-plugin&lt;/artifactId&gt;
  &lt;configuration&gt;
    &lt;!-- jrubyHome points to the JRuby installation you wish to use (usually ${env.JRUBY_HOME}) --&gt;
    &lt;jrubyHome&gt;${env.JRUBY_HOME}&lt;/jrubyHome&gt;
    &lt;!-- sourceDirectory references where your RSpec tests reside --&gt;
    &lt;sourceDirectory&gt;${basedir}/src/test/specs&lt;/sourceDirectory&gt;
    &lt;!-- outputDirectory specifies where the RSpec report should be placed --&gt;
    &lt;outputDirectory&gt;${basedir}/target&lt;/outputDirectory&gt;
    &lt;!--&lt;skipTests&gt;true&lt;/skipTests&gt;--&gt;
  &lt;/configuration&gt;
  &lt;executions&gt;
    &lt;execution&gt;
      &lt;id&gt;test&lt;/id&gt;
      &lt;phase&gt;test&lt;/phase&gt;
      &lt;goals&gt;
        &lt;goal&gt;spec&lt;/goal&gt;
      &lt;/goals&gt;
    &lt;/execution&gt;
  &lt;/executions&gt;
&lt;/plugin&gt;
</code>
</pre>
Now, just start flinging out specs in ./src/test/specs/.

This is a portion of a test against a JBoss-VFS VirtualFileHandler implementation, written in Java in WarRootHandler.java:
<pre>
  <code>
describe WarRootHandler do

  before(:each) do
    @context = RailsAppContextFactory.getInstance.createRoot( "ballast", File.dirname( __FILE__ ) + '/../ballast' )
    @root = @context.get_war_root_handler
  end

  it "should have a rails:// URL" do
    @root.to_uri.to_string.should eql( "rails://ballast/" )
  end

  it "should be resolvable through java URL handlers" do
    url = java.net.URL.new( "rails://ballast/" )
    url.to_s.should_not be_nil
  end

  it "should delegate for WEB-INF requests" do
    web_inf = @root.get_child( 'WEB-INF' )
    web_inf.should_not be_nil
    jboss_rails_yml = web_inf.get_child( 'jboss-rails.yml' )
    jboss_rails_yml.should_not be_nil
  end
end
</code>
</pre>
