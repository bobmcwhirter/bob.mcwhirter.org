
module Awestruct
  module Extensions
    class Tagger

      class TagStat
        attr_accessor :pages
        attr_accessor :group
        def initialize(tag, pages)
          @tag   = tag
          @pages = pages
        end

        def to_s
          @tag
        end
      end

      def initialize(layout, output_path='tags')
        @layout = layout.to_s
        @output_path = output_path
      end

      def execute(site)
        @tags ||= {}
        site.pages.each do |page|
          tags = page.tags
          if ( tags )
            tags.each do |tag|
              tag = tag.to_s
              @tags[tag] ||= TagStat.new( tag, [] )
              @tags[tag].pages << page
            end
          end
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
        page.layout = @layout
        page.tags = ordered_tags
        site.pages << page
      end
    end
  end
end
