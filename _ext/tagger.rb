
module Awestruct
  module Extensions
    class Tagger

      class TagStat
        attr_accessor :pages
        attr_accessor :group
        attr_accessor :primary_page
        def initialize(tag, pages)
          @tag   = tag
          @pages = pages
        end

        def to_s
          @tag
        end
      end

      def initialize(tagged_items_property, input_path, output_path='tags', pagination_opts={})
        @tagged_items_property = tagged_items_property
        @input_path  = input_path
        @output_path = output_path
        @pagination_opts = pagination_opts
      end

      def execute(site)
        @tags ||= {}
        all = site.send( @tagged_items_property )
        return if ( all.nil? || all.empty? ) 

        all.each do |page|
          tags = page.tags
          if ( tags && ! tags.empty? )
            tags.each do |tag|
              tag = tag.to_s
              @tags[tag] ||= TagStat.new( tag, [] )
              @tags[tag].pages << page
            end
          end
        end

        all.each do |page|
          page.tags = page.tags.collect{|t| @tags[t]}
        end

        ordered_tags = @tags.values
        ordered_tags.sort!{|l,r| -(l.pages.size <=> r.pages.size)}
        ordered_tags = ordered_tags[0,100]
        ordered_tags.sort!{|l,r| l.to_s <=> r.to_s}

        min = 9999
        max = 0

        ordered_tags.each do |tag|
          min = tag.pages.size if ( tag.pages.size < min )
          max = tag.pages.size if ( tag.pages.size > max )
        end

        span = max - min
        slice = span / 6

        ordered_tags.each do |tag|
          adjusted_size = tag.pages.size - min
          scaled_size = adjusted_size / slice
          tag.group = ( tag.pages.size - min ) / slice
        end

        page = HamlFile.new( site, File.join( File.dirname(__FILE__), 'tags.html.haml' ), 'tags' )
        @tags.values.each do |tag|
          paginator = Awestruct::Extensions::Paginator.new( @tagged_items_property, @input_path, { :remove_input=>false, :output_prefix=>File.join( @output_path, tag.to_s), :collection=>tag.pages }.merge( @pagination_opts ) )
          primary_page = paginator.execute( site )
          tag.primary_page = primary_page
        end

        #page = HamlFile.new( site, File.join( File.dirname(__FILE__), 'tags.html.haml' ), 'tags' )
        #page.layout = @layout
        #page.tags = ordered_tags
        #site.pages << page
      end
    end
  end
end
