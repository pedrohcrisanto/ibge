require 'correios-cep'

class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /addresses
  # GET /addresses.json
  def index
    addresses = Address.all
    cities = []
    rank_cities = []
    
    addresses.each do |address|
      cities << address.city
    end
    
    cities.uniq.each do |city|
      count_city = Address.where(city: city).count 
      rank_cities << { city: city, count: count_city } 
    end
    
    @cities_rank = rank_cities
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end
  
  def fill
    address_check =  Address.find_by(user: current_user)
    cep = params[:cep_service]
    
    if address_check.present?
      return redirect_to edit_address_path(address_check), alert: "Voce não preencheu o cep!" if cep.blank?
    
      redirect_to edit_address_path(address_check, cep_service: params[:cep_service]), notice: "Atualizado com sucesso!"
    else 
      return redirect_to new_address_path, alert: "Voce não preencheu o cep!" if cep.blank?
      
      data = CepService.new(cep).find
    
      @address = Address.new(:zip => data.zip , street: data.street, complement: data.complement, neighborhood: data.neighborhood, city: data.city, uf: data.uf, ibge_code: data.ibge_code)
  
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
      finder = Correios::CEP::AddressFinder.new
      address = finder.get(params[:cep_service])
      
      @address.zip = address[:zipcode]
      @address.street = address[:address]
      @address.complement = address[:complement]
      @address.neighborhood = address[:neighborhood]
      @address.city = address[:city]
      @address.uf = address[:state]
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
