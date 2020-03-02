class TripsController < ApplicationController

  def show
    @trip = Trip.find(params[:id])
    authorize @trip
  end

  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user if user_logded_in?
    authorize(@trip)
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def delete
    @trip = Trip.find(params[:id])
    authorize @trip
    @trip.destroy
  end

  private

  def trip_params
    params.require(:trip).permit(:start_date, :end_date, :gender, :age, :origin, :purpose, :location )
  end
end
