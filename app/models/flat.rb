class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :location, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :availability_start, presence: true
  validates :availibility_end, presence: true
  validate :availability_dates_valid


  def availability_dates_valid
    if availability_start && availibility_end && availability_start >= availibility_end
      errors.add(:availability_start, "must be before availability end")
    end
  end

  def available_between?(start_date, end_date)
    bookings.confirmed.none? do |booking|
      booking.check_in < end_date && start_date < booking.check_out
    end
  end

  def update_availability_dates
    confirmed_bookings = bookings.confirmed.order(:check_in)
    if confirmed_bookings.any?
      self.availability_start = [availability_start, confirmed_bookings.last.check_out].max
    end
    save!
  end
end
