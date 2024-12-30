class Article < ApplicationRecord
  belongs_to :author, class_name: "User"
  
  has_rich_text :rich_body
end
