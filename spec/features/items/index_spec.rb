require 'rails_helper'

RSpec.describe 'the items index' do
  before :each do
    test_data
  end

  describe "As a Vistor" do
    it "displays all item's name, price, and the name of the supermarket that it belongs to" do
      visit "/items"

      within "#items-#{@oats.id}" do
        expect(page).to have_content(@oats.name)
        expect(page).to have_content(@oats.price)
        expect(page).to have_content(@oats.supermarket_name)
        expect(page).to_not have_content(@mango.name)
        expect(page).to_not have_content(@apple.name)
      end
      within "#items-#{@cheese.id}" do
        expect(page).to have_content(@cheese.name)
        expect(page).to have_content(@cheese.price)
        expect(page).to have_content(@cheese.supermarket_name)
        expect(page).to_not have_content(@oats.name)
        expect(page).to_not have_content(@rice.name)
      end
    end

    it "displays the count of customers that bought that item" do
      CustomerItem.create!(customer_id: @sue.id, item_id: @apple.id)
      CustomerItem.create!(customer_id: @bob.id, item_id: @mango.id)
      CustomerItem.create!(customer_id: @sue.id, item_id: @mango.id)
      visit "/items"

      within "#items-#{@cheese.id}" do
        expect(page).to have_content("number of customers who bought this item: 1")
        expect(page).to_not have_content("number of customers who bought this item: 2")
        expect(page).to_not have_content("number of customers who bought this item: 3")
      end

      within "#items-#{@mango.id}" do
        expect(page).to have_content("number of customers who bought this item: 3")
        expect(page).to_not have_content("number of customers who bought this item: 2")
        expect(page).to_not have_content("number of customers who bought this item: 1")
      end

      within "#items-#{@apple.id}" do
        expect(page).to have_content("number of customers who bought this item: 2")
        expect(page).to_not have_content("number of customers who bought this item: 3")
        expect(page).to_not have_content("number of customers who bought this item: 1")
      end
    end
  end
end