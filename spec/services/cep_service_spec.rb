require "rails_helper"

describe CepService do
  describe "#find" do
    let(:instance) { described_class.new(cep) }

    context "with valid cep" do
      subject { instance.find }

      let(:cep) { "58101245" }
    
      it "returns cep data" do
          expect(subject.zip).to eq "58101-245"
          expect(subject.street).to eq "Rua Rodrigo Santiago de Brito Pereira"
          expect(subject.complement).to eq ""
          expect(subject.neighborhood).to eq "Areia Dourada"
          expect(subject.city).to eq "Cabedelo"
          expect(subject.uf).to eq "PB"
          expect(subject.ibge_code).to eq "2503209"
      end
    end

    context "with invalid cep" do
      subject { instance.find }

      let(:cep) { "123" }

      it "return invalid message" do
          expect(subject).to eq "Algo deu errado!"
      end
    end
  end
end
