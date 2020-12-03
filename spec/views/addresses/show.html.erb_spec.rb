require 'rails_helper'

RSpec.describe "addresses/show", type: :view do
  before(:each) do
    @address = assign(:address, Address.create!(
      zip: "Zip",
      street: "Street",
      complement: "Complement",
      neighborhood: "Neighborhood",
      city: "City",
      uf: "Uf",
      ibge_code: "Ibge Code",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Zip/)
    expect(rendered).to match(/Street/)
    expect(rendered).to match(/Complement/)
    expect(rendered).to match(/Neighborhood/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Uf/)
    expect(rendered).to match(/Ibge Code/)
    expect(rendered).to match(//)
  end
end
