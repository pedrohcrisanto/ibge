class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /addresses
  # GET /addresses.json

  def index
    addresses = Address.all
    rank_cities = []

    addresses.uniq.each do |address|
      count_city = Address.where(city: address.city).count 
      rank_cities <<  { city: address.city, uf: address.uf, count: count_city }
    end
    
    @cities_rank = rank_cities.uniq
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end
  
  def fill
    address_check =  Address.find_by(user: current_user)
    cep = params[:cep_service]
    
    if address_check.present?
      if cep.blank? 
        redirect_to edit_address_path(address_check), alert: "Voce não preencheu o cep!"
      else
        redirect_to edit_address_path(address_check, cep_service: params[:cep_service])
      end
    else 
      redirect_to new_address_path, alert: "Voce não preencheu o cep!" if cep.blank?
      
      service = CepService.new(cep)
      
      if service.find
        @address = Address.new(**service.data.to_h)
        flash[:notice] = service.message
      else
        flash[:alert] = service.message
      end
    
      render :new
    end
  end

  # GET /addresses/new
  def new
    address =  Address.find_by(user: current_user)
    if address.present?
      redirect_to edit_address_path(address)
    else 
      @address = Address.new
    end
  end

  # GET /addresses/1/edit
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

  # POST /addresses
  # POST /addresses.json
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

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
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

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:zip, :street, :complement, :neighborhood, :city, :uf, :ibge_code, :user_id)
    end
end
