require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'valid image' do
    image = Image.new(title: 'name', link: 'http://www.google.com')
    assert image.valid?
  end

  test 'link cannot be empty' do
    image = Image.new(title: 'name')
    assert_not image.valid?
  end

  test 'title cannot be empty' do
    image = Image.new(link: 'http://www.google.com')
    assert_not image.valid?
  end

  test 'valid url' do
    image = Image.new(link: '123456', title: 'false url')
    assert_not image.valid?
  end
end
