module PageObjects
  module Images
    class ImageInfo < AePageObjects::Element
      def url
        node.find('img')[:src]
      end

      def title
        node.find('img')[:title]
      end

      def tags
        node.all('.js-image-tags').map(&:text)
      end

      def click_tag!(tag_name)
        node.all('.js-tag-class').map do |link|
          link.click if link.text == tag_name
        end
        window.change_to(IndexPage)
      end
    end
  end
end

