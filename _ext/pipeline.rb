require 'tagger'

Awestruct::Extensions::Pipeline.new do
  extension Awestruct::Extensions::Posts.new( '/blog' ) 
  extension Awestruct::Extensions::Paginator.new( :posts, '/index', :per_page=>20 )
  extension Awestruct::Extensions::Tagger.new( :base )
  extension Awestruct::Extensions::Indexifier.new
end

