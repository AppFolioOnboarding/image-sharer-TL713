module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      element :image, locator: 'img'
      element :title, locator: '.js-image-title'

      def image_url
        node.find('img')[:src]
      end

      def delete
        node.find('.js-delete-link').click
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        node.find('.js-delete-link').click
        node.driver.browser.switch_to.alert.accept
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        node.click_on('Image Index Page')
        window.change_to(IndexPage)
      end
    end
  end
end
