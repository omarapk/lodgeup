class BookingsController < ApplicationController
  before_action :set_flat, only: [:new, :create]
  before_action :set_booking, only: [:show, :destroy]
  before_action :authorize_user, only: [:show, :destroy]
  def index
    @bookings = current_user.bookings.includes(:flat)
  end

  def show
  end

  def new
    @booking = @flat.bookings.new
  end

def create
  @flat = Flat.find(params[:flat_id])
  @booking = @flat.bookings.new(booking_params)
  @booking.user = current_user

  if @booking.save
    @flat.update_availability_dates
    redirect_to @flat, notice: "Booking created successfully"
  else
    render "flats/show", status: :unprocessable_entity
  end
end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end


  private

  def set_flat
    @flat = Flat.find(params[:flat_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def authorize_user
    redirect_to bookings_path unless @booking.user == current_user
  end

  def booking_params
    params.require(:booking).permit(:check_in, :check_out, :status)
  end
end
