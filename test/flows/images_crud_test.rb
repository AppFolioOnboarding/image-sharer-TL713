require 'flow_test_helper'

class ImagesCrudTest < FlowTestCase
  test 'add an image with invaild url' do
    images_index_page = PageObjects::Images::IndexPage.visit

    new_page = images_index_page.add_new_image!

    tags = %w[example test]
    new_page = new_page.create_image!(
      title: 'test',
      link: '1234567',
      tags: tags.join(', ')
    ).as_a(PageObjects::Images::NewPage)
    assert_equal 'is not a valid URL', new_page.image_link.error_message
  end

  test 'add an image with vaild url' do
    images_index_page = PageObjects::Images::IndexPage.visit
    new_page = images_index_page.add_new_image!
    tags = %w[example test]

    image_link = 'https://media.gettyimages.com/photos/bendy-road-mam-tor-castleton-picture-id513199459?s=2048x2048'
    show_page = new_page.create_image!(
      title: 'test',
      link: image_link,
      tags: tags.join(', ')
    ).as_a(PageObjects::Images::ShowPage)
    assert_equal image_link, show_page.image_url

    index_page = show_page.go_back_to_index!
    assert index_page.showing_image?(url: image_link, tags: tags)
  end

  test 'delete an image' do
    keep_url = 'https://media.gettyimages.com/photos/young-man-takes-photo-with-cell-phone-at-sunrise-on-an-alpine-meadow-picture-id1167517379?s=2048x2048'
    delete_url = 'https://media.gettyimages.com/photos/woman-exploring-jungle-on-bali-island-indonesia-picture-id1178939192?s=2048x2048'
    Image.create!([{ title: 'keep', link: keep_url, tag_list: 'test, keep' },
                   { title: 'delete', link: delete_url, tag_list: 'test, delete' }])

    images_index_page = PageObjects::Images::IndexPage.visit
    assert_equal 2, images_index_page.images.count
    assert images_index_page.showing_image?(url: keep_url)
    assert images_index_page.showing_image?(url: delete_url)

    image_to_delete = images_index_page.images.find do |image|
      image.url == delete_url
    end
    image_show_page = image_to_delete.view!

    image_show_page.delete do |confirm_dialog|
      assert_equal 'Do you want to delete this image?', confirm_dialog.text
      confirm_dialog.dismiss
    end

    images_index_page = image_show_page.delete_and_confirm!
    assert_equal 'Image deleted successfully!', images_index_page.flash_message.text

    assert_equal 1, images_index_page.images.count
    assert_not images_index_page.showing_image?(url: delete_url)
    assert images_index_page.showing_image?(url: keep_url)
  end
end
