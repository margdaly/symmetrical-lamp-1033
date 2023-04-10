require 'rails_helper'

RSpec.describe 'the customer show' do
  before :each do
    test_data
  end

  describe "As a Visitor, When I visit a customer show page" do
    it "displays the customer's name" do
      visit "/customers/#{@frank.id}"

      expect(page).to have_content(@frank.name)
      expect(page).to_not have_content(@sue.name)
      expect(page).to_not have_content(@bob.name)

      visit "/customers/#{@sue.id}"

      expect(page).to have_content(@sue.name)
      expect(page).to_not have_content(@frank.name)
      expect(page).to_not have_content(@bob.name)
    end

   it "lists the customer's items including name, price, and the name of the supermarket that it belongs to" do
      visit "/customers/#{@frank.id}"

      within "#items-#{@oats.id}" do
        expect(page).to have_content(@oats.name)
        expect(page).to have_content(@oats.price)
        expect(page).to have_content(@oats.supermarket_name)
        expect(page).to_not have_content(@rice.name)
        expect(page).to_not have_content(@pear.name)
      end 

      within "#items-#{@rice.id}" do
        expect(page).to have_content(@rice.name)
        expect(page).to have_content(@rice.price)
        expect(page).to have_content(@rice.supermarket_name)
        expect(page).to_not have_content(@oats.name)
        expect(page).to_not have_content(@pear.name)
      end 

      within "#items-#{@pear.id}" do
        expect(page).to have_content(@pear.name)
        expect(page).to have_content(@pear.price)
        expect(page).to have_content(@pear.supermarket_name)
        expect(page).to_not have_content(@oats.name)
        expect(page).to_not have_content(@rice.name)
      end 
    end

    it "has form to add an item to this customer" do
      visit "/customers/#{@sue.id}"

      within "#add-item" do
        expect(page).to have_field(:item_id)
        expect(page).to have_content("Add item to sue's cart")
      end
    end

    it "When I fill in a field with the id of an existing item, 
    And I click submit, Then I am redirected back to the customer's show page, 
    And I see the item now listed under this customer's items" do
    visit "/customers/#{@sue.id}"

    expect(page).to_not have_content(@oats.name)
    fill_in :item_id, with: @oats.id
    click_on("Submit")

    expect(current_path).to eq("/customers/#{@sue.id}")
    within "#items-#{@oats.id}"
      expect(page).to have_content(@oats.name)
      expect(page).to have_content(@oats.price)
      expect(page).to have_content(@oats.supermarket_name)
    end
  end
end  