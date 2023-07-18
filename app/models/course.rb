class Course < ApplicationRecord
  has_one_attached :video
  belongs_to :instructor
  belongs_to :category

  validates :title, presence: true, uniqueness: true
  validates :about, presence: true
  validates :video, presence: true
  validates :status, inclusion: { in: ["active", "inactive"] }
end
