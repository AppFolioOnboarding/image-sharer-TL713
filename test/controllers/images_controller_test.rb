require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'new_image_path returns a 200 response' do
    get new_image_path
    assert_response :ok
  end

  test 'save image and valid image' do
    post images_path, params: { image: { title: 'image', link: 'http://www.example.com' } }
    image_test = Image.last
    assert_equal 'image', image_test.title
    assert_equal 'http://www.example.com', image_test.link
    assert_redirected_to image_path(image_test)
  end

  test 'image page shows error message ' do
    post images_path, params: { image: { title: nil, link: nil } }
    assert_response :ok
    assert_select '.js-error-block ul li' do |elements|
      assert_equal 3, elements.length
      assert_equal "Link can't be blank", elements[0].text
      assert_equal 'Link is not a valid URL', elements[1].text
      assert_equal "Title can't be blank", elements[2].text
    end
  end
end
