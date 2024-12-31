class Article < ApplicationRecord
  belongs_to :author, class_name: "User"
  
  has_many :comments

  has_rich_text :rich_body
  has_one_attached :photo
  
  validates :title, presence: true
  validates :rich_body, length: { minimum: 500, too_short: "Deve ter no mínimo 500 caracteres" }
end
