require 'tagger'

require 'awestruct/extensions/intense_debate'

Awestruct::Extensions::Pipeline.new do

  extension Awestruct::Extensions::Posts.new( '/blog' ) 
  extension Awestruct::Extensions::Paginator.new( :posts, '/index', :per_page=>10 )
  extension Awestruct::Extensions::Tagger.new( :posts, '/index', '/blog/tags', :per_page=>10 )
  extension Awestruct::Extensions::Atomizer.new( :posts, '/blog.atom', :num_entries=>20 )
  extension Awestruct::Extensions::IntenseDebate.new
  extension Awestruct::Extensions::Indexifier.new
end

