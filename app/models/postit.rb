class Postit < ApplicationRecord
  validates_presence_of :title, :body, :user_id

  belongs_to :user
end
