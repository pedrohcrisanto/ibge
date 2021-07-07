class CepService
    include HTTParty
  
    URL = "https://viacep.com.br/ws/"
    FORMAT = "json"
  
    CepServiceData = Struct.new(:zip, :street, :complement, :neighborhood, :city, :uf, :ibge_code, keyword_init: true)
  
    attr_reader :data, :message
  
    def initialize(cep)
      @cep = cep
      @data = CepServiceData.new
    end
  
    def find
      response = call
    
      if response.success? && response["erro"].nil?
        process_response(response)
        
        @message = "Seus dados foram preenchidos corretamente."

        true
      else
        process_error_message(response)

        false
      end
    end
  
    private
  
    attr_reader :cep
  
    def call
      self.class.get("#{URL}#{cep}/#{FORMAT}/")
    end
  
    def process_response(response)
      parse_cep_data(response_as_object(response.body))
    end

    def parse_cep_data(response)
      data.zip = response.cep
      data.street = response.logradouro
      data.complement = response.complemento
      data.neighborhood = response.bairro
      data.uf = response.uf
      data.ibge_code = response.ibge
      data.city = response.localidade
    end
  
    def process_error_message(response)
      @message = "CEP Inválido!" if response.code == 400 || response["erro"].present?
    end
  
    def response_as_object(response)
      JSON.parse(response, object_class: OpenStruct)
    end
  end