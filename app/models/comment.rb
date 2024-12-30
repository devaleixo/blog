class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", optional: true
  belongs_to :article

  validates :body, presence: true
  validates :body, length: { maximum: 200 }
end
