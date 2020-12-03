require 'rails_helper'

RSpec.describe "addresses/edit", type: :view do
  before(:each) do
    @address = assign(:address, Address.create!(
      zip: "MyString",
      street: "MyString",
      complement: "MyString",
      neighborhood: "MyString",
      city: "MyString",
      uf: "MyString",
      ibge_code: "MyString",
      user: nil
    ))
  end

  it "renders the edit address form" do
    render

    assert_select "form[action=?][method=?]", address_path(@address), "post" do

      assert_select "input[name=?]", "address[zip]"

      assert_select "input[name=?]", "address[street]"

      assert_select "input[name=?]", "address[complement]"

      assert_select "input[name=?]", "address[neighborhood]"

      assert_select "input[name=?]", "address[city]"

      assert_select "input[name=?]", "address[uf]"

      assert_select "input[name=?]", "address[ibge_code]"

      assert_select "input[name=?]", "address[user_id]"
    end
  end
end
