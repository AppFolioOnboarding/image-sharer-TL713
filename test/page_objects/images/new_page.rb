module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_image
      path :images # from failed create

      form_for :simple_form do
        element :image_title, locator: '.js-title'
        element :image_link, locator: '.js-link'
        element :image_tag_list, locator: '.js-tag-list'
      end

      def create_image!(title: nil, link: nil, tags: nil)
        image_title.set(title) if title.present?
        image_link.set(link) if link.present?
        image_tag_list.set(tags)
        node.click_button('Create Image')
        window.change_to(ShowPage, self.class)
      end

      def go_back_to_index!
        node.click_button('Image Index Page')
        window.change_to(IndexPage)
      end

      def go_back_to_upload!
        node.click_on('Back to Upload')
        window.change_to(NewPage)
      end
    end
  end
end
