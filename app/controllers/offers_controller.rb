class OffersController < ApplicationController
  include Pagy::Backend

  before_action :set_offer, only: [:show, :update, :destroy]

  # GET /offers
  def index
    @offers = Offer.all

    render json: @offers
  end

  # GET /offers/1
  def show
    render json: @offer
  end

  # POST /offers
  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      render json: @offer, status: :created, location: @offer
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /offers/1
  def update
    if @offer.update(offer_params)
      render json: @offer
    else
      render json: @offer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /offers/1
  def destroy
    @offer.destroy
  end

  # GET /offers/search
  def search
    #res = IntrosService.call
    query = params[:query]
    page = params[:page] || 1
    wildcard_search = "%#{query}%"

    options = {page: page}
    pagy, records = pagy(Offer.where('company ILIKE ?', wildcard_search), options)
    pagy_metadata = pagy_metadata(pagy)

    render json: {
      offers: records,
      total_count: pagy_metadata.fetch(:count),
      total_pages: pagy_metadata.fetch(:pages),
      current_page: pagy_metadata.fetch(:page),
      per_page: pagy_metadata.fetch(:items)
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def offer_params
      params.require(:offer).permit(:price, :company)
    end
end
