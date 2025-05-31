class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  validates :check_in, presence: true
  validates :check_out, presence: true
  validate :check_in_before_check_out


  private

  def check_in_before_check_out
    if check_in && check_out && check_in >= check_out
      errors.add(:check_in, "must be before check out date")
    end
  end
end
