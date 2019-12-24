module PageObjects
  module Images
    class ImageItem < AePageObjects::Element
      def url
        node.find('img')[:src]
      end

      def title
        node.find('img')[:title]
      end

      def tags
        node.all('.js-image-tags').map(&:text)
      end

      def click_image!
        node.find('.js-show-page-link', &:click)
        window.change_to(ShowPage)
      end
    end
  end
end
