class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list
  validates :comment, length: { minimum: 6 }
  validates :list_id, uniqueness: { scope: :movie_id,
    message: "should have only 1 movie per list" }
end
