class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  def index
    @contacts = Contact.all

    render json: @contacts
  end

  def show
    render json: @contact
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.company = relationship_params[:company]
    @contact.offers = relationship_params[:offers] || []
    @contact.projects = relationship_params[:projects] || []

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: { errors: [@contact.errors] }, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      @contact.company = relationship_params[:company] if relationship_params[:company]
      @contact.offers = relationship_params[:offers] if relationship_params[:offers]
      @contact.projects = relationship_params[:projects] if relationship_params[:projects]
      render json: @contact
    else
      render json: { errors: [@contact.errors] }, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:data).require(:attributes).permit(
      :family_name, :given_name, :company_id, :title, :phone, :email,
      :website, :address, :customer_id, :additional_info
    )
  end
end
