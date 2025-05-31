class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :location, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :availability_start, presence: true
  validates :availibility_end, presence: true


  private

  def availability_dates_valid
    if availability_start && availibility_end && availability_start >= availibility_end
      errors.add(:availability_start, "must be before availability end")
    end
  end
end
