class Image < ApplicationRecord
  validates :link,
            presence: true,
            url: true
  validates :title, presence: true
end
