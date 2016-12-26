class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :body, presence: true
end
