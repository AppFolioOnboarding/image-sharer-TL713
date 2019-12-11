require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'new_image_path returns a 200 response' do
    get new_image_path
    assert_response :ok
  end

  test 'link saved in database' do
    @image = Image.new(link: 'http://www.example.com', title: 'image')
    assert @image.save
  end

  test 'image_path returns a 200 response' do
    @image = Image.new(link: 'http://www.example.com', title: 'image')
    @image.save
    get image_path(@image)
    assert_response :ok
  end
end
