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

  test 'image upload page shows error message ' do
    post images_path, params: { image: { title: nil, link: nil } }
    assert_response :ok
    assert_select '.js-error-block ul li' do |elements|
      assert_equal 3, elements.length
      assert_equal "Link can't be blank", elements[0].text
      assert_equal 'Link is not a valid URL', elements[1].text
      assert_equal "Title can't be blank", elements[2].text
    end
  end

  test 'image index page shows images' do
    Image.destroy_all
    image_test_list = [
      { title: 'bridge', link: 'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg/' \
      '?cs=srgb&dl=beautiful-beauty-blue-bright-414612.jpg&fm=jpg' },
      { title: 'road', link: 'https://images.pexels.com/photos/237018/pexels-photo-237018.jpeg?' \
      'auto=compress&cs=tinysrgb&dpr=2&h=650&w=940' },
      { title: 'coast', link: 'https://images.pexels.com/photos/1076429/pexels-photo-1076429.jpeg?' \
      'auto=compress&cs=tinysrgb&dpr=2&h=650&w=940' }
    ]
    Image.create(image_test_list)

    # test image index page response ok
    get images_path
    assert_response :ok

    # test image display & order
    assert_select 'img', image_test_list.length do |images|
      image_test_reversed = image_test_list.reverse
      images.each_with_index do |im, index|
        assert im.attributes['width'].value.to_i <= 400
        assert_equal image_test_reversed[index][:link], im.attributes['src'].value
        assert_equal image_test_reversed[index][:title], im.attributes['title'].value
      end
    end
  end

  test 'upload page redirect to home page' do
    get new_image_path
    assert_select '.js-index-page-link' do |element|
      assert_equal 1, element.length
      assert_equal '/', element[0].attr('href')
      assert_equal 'Image Index Page', element[0].text
    end
  end

  test 'show page redirect to home page' do
    post images_path, params: { image: { title: 'image', link: 'http://www.example.com' } }
    image_test = Image.last
    get image_path(image_test)
    assert_select '.js-index-page-link' do |element|
      assert_equal 1, element.length
      assert_equal '/', element[0].attr('href')
      assert_equal 'Image Index Page', element[0].text
    end
  end
end
