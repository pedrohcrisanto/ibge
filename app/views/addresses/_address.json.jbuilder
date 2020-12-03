json.extract! address, :id, :zip, :street, :complement, :neighborhood, :city, :uf, :ibge_code, :user_id, :created_at, :updated_at
json.url address_url(address, format: :json)
