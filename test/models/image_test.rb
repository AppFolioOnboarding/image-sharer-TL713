require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'valid image' do
    image = Image.new(title: 'name', link: 'http://www.google.com', tag_list: '')
    assert image.valid?
    assert_not image.errors.any?
  end

  test 'link cannot be empty' do
    image = Image.new(title: 'name', tag_list: '')
    assert_not image.valid?
    assert_equal "Link can't be blank", image.errors.full_messages[0]
  end

  test 'title cannot be empty' do
    image = Image.new(link: 'http://www.google.com', tag_list: '')
    assert_not image.valid?
    assert_equal "Title can't be blank", image.errors.full_messages[0]
  end

  test 'url need to be valid' do
    image = Image.new(link: '123456', title: 'false url', tag_list: '')
    assert_not image.valid?
    assert_equal 'Link is not a valid URL', image.errors.full_messages[0]
  end

  test 'empty tag list' do
    image = Image.new(link: 'http://www.example.com', title: 'test', tag_list: '')
    assert image.valid?
  end

  test 'single tag list' do
    image = Image.new(link: 'http://www.example.com', title: 'test', tag_list: 'example')
    assert image.valid?
  end

  test 'multiple tag list' do
    image = Image.new(link: 'http://www.example.com', title: 'test', tag_list: 'example, test')
    assert image.valid?
  end
end
