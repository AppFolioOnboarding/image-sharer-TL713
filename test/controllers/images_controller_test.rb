require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'new_image_path returns a 200 response' do
    get new_image_path
    assert_response :ok
  end

  test 'save image and valid image' do
    post images_path, params: { image: { title: 'image', link: 'http://www.example.com', tag_list: '' } }
    image_test = Image.last
    assert_equal 'image', image_test.title
    assert_equal 'http://www.example.com', image_test.link
    assert_equal [], image_test.tag_list
    assert_redirected_to image_path(image_test)
  end

  test 'image upload page shows error message ' do
    post images_path, params: { image: { title: nil, link: nil, tag_list: '' } }
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
    post images_path, params: { image: { title: 'image', link: 'http://www.example.com', tag_list: '' } }
    image_test = Image.last
    get image_path(image_test)
    assert_select '.js-index-page-link' do |element|
      assert_equal 1, element.length
      assert_equal '/', element[0].attr('href')
      assert_equal 'Image Index Page', element[0].text
    end
    assert_select '.js-tag-list', text: ''
  end

  test 'default 20 images after set up' do
    Image.destroy_all
    Rails.application.load_seed
    assert_equal 20, Image.count
  end

  test 'save tags' do
    assert_difference %w[ActsAsTaggableOn::Tag.count ActsAsTaggableOn::Tagging.count], 2 do
      assert_difference 'Image.count', 1 do
        post images_path, params: { image: {
          title: 'image',
          link: 'http://www.example.com',
          tag_list: 'example, test'
        } }
      end
    end
    image_test = Image.last
    assert_equal 'image', image_test.title
    assert_equal 'http://www.example.com', image_test.link
    assert_equal %w[example test], image_test.tag_list
    assert_redirected_to image_path(image_test)
  end

  test 'show tags' do
    image = Image.create(
      title: 'image',
      link: 'http://www.example.com',
      tag_list: 'example, test'
    )
    get image_path(image)
    assert_select '.js-tag-list', text: 'example, test'
  end

  test 'index has title tags and links to show' do
    image = { title: 'bridge', link: 'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg/' \
      '?cs=srgb&dl=beautiful-beauty-blue-bright-414612.jpg&fm=jpg', tag_list: 'example, test' }
    tags_list = %w[example test]
    Image.create!(image)
    get images_path
    assert_response :ok
    # test image display & order
    assert_select '.js-image-title', text: 'bridge'
    assert_select '.js-image-tags' do |element|
      element.each_with_index do |ele, index|
        assert_equal tags_list[index], ele.text.strip
      end
    end
    assert_select '.js-show-page-link' do |ele|
      assert_equal "/images/#{Image.last[:id]}", ele[0].attr('href')
    end
  end

  test 'index page should display images with a tag on it' do
    Image.destroy_all

    image_list = [
      { title: 'Santa Barbara',
        link: 'https://www.visitcalifornia.com/sites/default/files/styles/welcome_image/public/vc_spotlight_santabarbara_hero_st_rm_529573764_1280x640_0.jpg',
        tag_list: %w[view SantaBarbara] },
      { title: 'SB',
        link: 'https://embedwistia-a.akamaihd.net/deliveries/14c7c6bd712d4d744121933e032bbaf6.webp?image_crop_resized=1280x750',
        tag_list: 'SantaBarbara' },
      { title: 'LA',
        link: 'https://embedwistia-a.akamaihd.net/deliveries/14c7c6bd712d4d744121933e032bbaf6.webp?image_crop_resized=1280x750',
        tag_list: 'LosAngeles' }
    ]
    sb_list = []
    image_list.each do |image|
      sb_list.append(image[:link]) if image[:tag_list].include?('SantaBarbara')
    end
    Image.create!(image_list)

    get images_path(tag: 'SantaBarbara')
    assert_response :ok

    assert_select('img') do |elements|
      assert_equal 2, elements.count
      elements.each_with_index do |ele, index|
        assert_equal sb_list.reverse[index], ele.attr('src')
      end
    end
  end

  test 'index displays all images when no tag selected' do
    Image.destroy_all
    image_list = [
      { title: 'Santa Barbara',
        link: 'https://www.visitcalifornia.com/sites/default/files/styles/welcome_image/public/vc_spotlight_santabarbara_hero_st_rm_529573764_1280x640_0.jpg',
        tag_list: %w[view SantaBarbara] },
      { title: 'SB',
        link: 'https://embedwistia-a.akamaihd.net/deliveries/14c7c6bd712d4d744121933e032bbaf6.webp?image_crop_resized=1280x750',
        tag_list: 'SantaBarbara' },
      { title: 'LA',
        link: 'https://embedwistia-a.akamaihd.net/deliveries/14c7c6bd712d4d744121933e032bbaf6.webp?image_crop_resized=1280x750',
        tag_list: 'LosAngeles' }
    ]
    Image.create!(image_list)
    get images_path
    assert_response :ok
    assert_select('img') do |elements|
      assert_equal image_list.length, elements.count
      elements.each_with_index do |ele, index|
        assert_equal image_list.reverse[index][:link], ele.attr('src')
      end
    end
  end

  test 'No image shows for index show nonexistent tag' do
    Image.destroy_all
    image_list = [{ title: 'Santa Barbara',
                    link: 'https://www.visitcalifornia.com/sites/default/files/styles/welcome_image/public/vc_spotlight_santabarbara_hero_st_rm_529573764_1280x640_0.jpg',
                    tag_list: %w[view SantaBarbara] },
                  { title: 'SB',
                    link: 'https://embedwistia-a.akamaihd.net/deliveries/14c7c6bd712d4d744121933e032bbaf6.webp?image_crop_resized=1280x750',
                    tag_list: 'Santa Barbara' }]
    Image.create!(image_list)
    get images_path(tag: 'Los Angeles')
    assert_response :ok
    assert_select 'img', count: 0
  end

  test 'tags redirect to show all' do
    Image.destroy_all
    Image.create!(title: 'SB',
                  link: 'https://embedwistia-a.akamaihd.net/deliveries/14c7c6bd712d4d744121933e032bbaf6.webp?image_crop_resized=1280x750',
                  tag_list: 'Santa Barbara')
    get images_path(tag: 'Santa Barbara')
    assert_select '.js-index-page-link' do |element|
      assert_equal '/', element[0].attr('href')
      assert_equal 'Back to All', element[0].text
    end
  end

  test 'delete image and redirect to home page' do
    Image.destroy_all
    img = Image.create!(title: 'SB',
                        link: 'https://embedwistia-a.akamaihd.net/deliveries/14c7c6bd712d4d744121933e032bbaf6.webp?image_crop_resized=1280x750',
                        tag_list: 'Santa Barbara')

    assert_equal 1, Image.count
    assert_difference 'Image.count', -1 do
      delete image_path(img)
    end
    assert_redirected_to root_path
    assert_equal 'Image deleted successfully!', flash[:notice]
  end

  test 'show page link to delete' do
    Image.destroy_all
    img = Image.create!(title: 'SB',
                        link: 'https://embedwistia-a.akamaihd.net/deliveries/14c7c6bd712d4d744121933e032bbaf6.webp?image_crop_resized=1280x750',
                        tag_list: 'Santa Barbara')

    get image_path(img)
    assert_response :ok
    assert_select '.js-delete-link' do |ele|
      assert_equal 'Do you want to delete this image?', ele.attr('data-confirm').text
      assert_equal 'delete', ele.attr('data-method').text
      assert_equal "/images/#{img[:id]}", ele.attr('href').text
    end
  end

  test 'home page removes deleted image' do
    Image.destroy_all
    image = { title: 'SB',
              link: 'https://embedwistia-a.akamaihd.net/deliveries/14c7c6bd712d4d744121933e032bbaf6.webp?image_crop_resized=1280x750',
              tag_list: 'Santa Barbara' }
    img = Image.create!(image)

    get root_path
    assert_response :ok
    assert_select 'img' do |ele|
      assert_equal image[:link], ele.attr('src').text
      assert_equal image[:title], ele.attr('title').text
    end

    assert_difference 'Image.count', -1 do
      delete image_path(img)

      get root_path
      assert_response :ok
      assert_select 'img', false
    end
  end
end
