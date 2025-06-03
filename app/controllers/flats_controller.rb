class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy, :bookings]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: :index

  def index
    @flats = Flat.all
  end

  def show
    @booking = Booking.new
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    if @flat.save
      redirect_to @flat, notice: "New flat created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @flat.update(flat_params)
      redirect_to @flat
    else
      render :edit
    end
  end

  def destroy
    @flat.destroy
    redirect_to flats_path
  end

  def bookings
    @bookings = @flat.bookings.order(created_at: :desc)
    render :unauthorized unless @flat.user == current_user
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:title, :description, :location, :price, :availability_start, :availibility_end, :photo)
  end

  def authorize_user
    unless @flat.user == current_user
      render :unauthorized
    end
  end
end
