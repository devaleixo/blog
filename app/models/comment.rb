class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", optional: true
  belongs_to :article

  validates :content, presence: true
  validates :content, length: { maximum: 200 }
end
