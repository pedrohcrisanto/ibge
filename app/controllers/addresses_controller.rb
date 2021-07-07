class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    addresses = Address.all
    rank_cities = []

    addresses.uniq.each do |address|
      count_city = Address.where(city: address.city).count 
      rank_cities <<  { city: address.city, uf: address.uf, count: count_city }
    end
    
    @cities_rank = rank_cities.uniq
  end

  def show
  end
  
  def fill
    address_check =  Address.find_by(user: current_user)
    cep = params[:cep_service]

    if address_check.present?
      cep.blank? ? ( redirect_to edit_address_path(address_check), alert: "Voce não preencheu o cep!" ) : (redirect_to edit_address_path(address_check, cep_service: params[:cep_service]))
    else
      service = CepService.new(cep)
      
      if service.find
        @address = Address.new(**service.data)

        flash[:notice] = service.message
      else
        flash[:alert] = service.message
      end
      
      if cep.blank?
        redirect_to new_address_path, alert: "Voce não preencheu o cep!"
      else
        render :new
      end
    end
  end

  def new
    address =  Address.find_by(user: current_user)
    
    if address.present?
      redirect_to edit_address_path(address)
    else 
      @address = Address.new
    end
  end

  def edit
    if params[:cep_service].present?
      service = CepService.new(params[:cep_service])

        if service.find
          @address.zip = service.data.zip
          @address.street = service.data.street
          @address.complement = service.data.complement
          @address.neighborhood = service.data.neighborhood
          @address.city = service.data.city
          @address.uf = service.data.uf
          @address.ibge_code = service.data.ibge_code
          
          flash[:notice] = service.message
        else
          flash[:alert] = service.message        
        end
    end
  end

  def create
    @address = Address.new(address_params.merge(user: current_user))

    respond_to do |format|
      if @address.save
        format.html { redirect_to addresses_path, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to addresses_path, notice: 'Address was successfully updated.' }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:zip, :street, :complement, :neighborhood, :city, :uf, :ibge_code, :user_id)
    end
end
