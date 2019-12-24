class Image < ApplicationRecord
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  validates :link,
            presence: true,
            url: true
  validates :title, presence: true
  validates :tag_list, presence: true
end
