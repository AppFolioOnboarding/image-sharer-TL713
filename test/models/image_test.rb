require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'valid image' do
    image = Image.new(title: 'name', link: 'http://www.google.com')
    assert image.valid?
    assert_not image.errors.any?
  end

  test 'link cannot be empty' do
    image = Image.new(title: 'name')
    assert_not image.valid?
    assert_equal "Link can't be blank", image.errors.full_messages[0]
  end

  test 'title cannot be empty' do
    image = Image.new(link: 'http://www.google.com')
    assert_not image.valid?
    assert_equal "Title can't be blank", image.errors.full_messages[0]
  end

  test 'url need to be valid' do
    image = Image.new(link: '123456', title: 'false url ')
    assert_not image.valid?
    assert_equal 'Link is not a valid URL', image.errors.full_messages[0]
  end
end
