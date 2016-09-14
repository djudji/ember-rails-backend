class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :update, :destroy]

  def index
    @offers = Offer.all

    render json: @offers
  end

  def show
    render json: @offer
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.project = relationship_params[:project]
    @offer.contacts = relationship_params[:contacts] || []
    @offer.tasks = relationship_params[:tasks] || []

    if @offer.save
      render json: @offer, status: :created, location: @offer
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @offer.update(offer_params)
      @offer.project = relationship_params[:project] if relationship_params[:project]
      @offer.contacts = relationship_params[:contacts] if relationship_params[:contacts]
      @offer.tasks = relationship_params[:tasks] if relationship_params[:tasks]
      render json: @offer
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @offer.destroy
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:data).require(:attributes).permit(:name, :price, :status, :valid_until)
  end
end
