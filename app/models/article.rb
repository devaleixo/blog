class Article < ApplicationRecord
  belongs_to :user
  
  has_rich_text :rich_body
end
