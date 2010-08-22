require 'tagger'

require 'awestruct/extensions/intense_debate'

Awestruct::Extensions::Pipeline.new do
  helper Awestruct::Extensions::IntenseDebate

  extension Awestruct::Extensions::Posts.new( '/blog' ) 
  extension Awestruct::Extensions::Paginator.new( :posts, '/index', :per_page=>10 )
  extension Awestruct::Extensions::Tagger.new( :posts, '/index', '/blog/tags', :per_page=>10 )
  extension Awestruct::Extensions::Indexifier.new
end

