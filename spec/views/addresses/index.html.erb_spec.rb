require 'rails_helper'

RSpec.describe "addresses/index", type: :view do
  before(:each) do
    assign(:addresses, [
      Address.create!(
        zip: "Zip",
        street: "Street",
        complement: "Complement",
        neighborhood: "Neighborhood",
        city: "City",
        uf: "Uf",
        ibge_code: "Ibge Code",
        user: nil
      ),
      Address.create!(
        zip: "Zip",
        street: "Street",
        complement: "Complement",
        neighborhood: "Neighborhood",
        city: "City",
        uf: "Uf",
        ibge_code: "Ibge Code",
        user: nil
      )
    ])
  end

  it "renders a list of addresses" do
    render
    assert_select "tr>td", text: "Zip".to_s, count: 2
    assert_select "tr>td", text: "Street".to_s, count: 2
    assert_select "tr>td", text: "Complement".to_s, count: 2
    assert_select "tr>td", text: "Neighborhood".to_s, count: 2
    assert_select "tr>td", text: "City".to_s, count: 2
    assert_select "tr>td", text: "Uf".to_s, count: 2
    assert_select "tr>td", text: "Ibge Code".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
