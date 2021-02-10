require "rails_helper"

describe CepService do
  describe "#find" do
    let(:instance) { described_class.new(cep) }

    context "with valid cep" do
      subject { instance.find }

      let(:cep) { "58101245" }

      it "returns cep data" do
        expect(subject).to be_truthy
        expect(instance.message).to "Seus dados foram preenchidos corretamente."
        expect(instance.data.zip).to eq "58101-245"
        expect(instance.data.street).to eq "Rua Rodrigo Santiago de Brito Pereira"
        expect(instance.data.complement).to eq ""
        expect(instance.data.neighborhood).to eq "Areia Dourada"
        expect(instance.data.city).to eq "Cabedelo"
        expect(instance.data.uf).to eq "PB"
        expect(instance.data.ibge_code).to eq "2503209"
      end
    end

    context "with invalid cep" do
      subject { instance.find }

      let(:cep) { "58101" }

      it "return invalid message" do
        expect(subject).to be_falsey
        expect(instance.message).to eq "CEP Inválido!"
      end
    end
  end
end
