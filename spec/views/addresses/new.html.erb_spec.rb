require 'rails_helper'

RSpec.describe "addresses/new", type: :view do
  before(:each) do
    assign(:address, Address.new(
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

  it "renders new address form" do
    render

    assert_select "form[action=?][method=?]", addresses_path, "post" do

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
