require_relative './image_item'

module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      collection :images, locator: '.js-image-list', item_locator: '.js-single-image', contains: ImageItem do
        def view!
          link = node.find('.js-show-page-link')
          link.click
          window.change_to(ShowPage)
        end
      end

      element :flash_message, locator: '.js-notice'

      def add_new_image!
        node.click_on('Upload image using url')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        images.any? do |image|
          image.url == url && ((tags.present? && image.tags == tags) || tags.nil?)
        end
      end
    end
  end
end
