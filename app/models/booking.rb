class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  validates :check_in, presence: true
  validates :check_out, presence: true
  validate :check_in_before_check_out
  validate :flat_must_be_available
  enum status: { pending: "pending", confirmed: "confirmed", declined: "declined" }

  def total_price
    number_of_nights = (check_out - check_in).to_i
    number_of_nights * flat.price
  end


  protected

  def check_in_before_check_out
    if check_in && check_out && check_in >= check_out
      errors.add(:check_in, "must be before check out date")
    end
  end
  def flat_must_be_available
    if flat && check_in && check_out && !flat.available_between?(check_in, check_out)
      errors.add(:base, "Flat is not available for the selected dates")
    end
  end
end
