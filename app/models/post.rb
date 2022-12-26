class Post < ApplicationRecord
  belongs_to :category
  searchkick
end
