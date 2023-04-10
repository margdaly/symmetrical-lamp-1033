require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it {should have_many(:customer_items)}
    it {should have_many(:customers).through(:customer_items)} 
  end

  before :each do
    test_data
  end

  describe '#instance_methods' do
    describe ".supermarket_name" do
      it "returns the name of the supermarket that the item belongs to" do
        expect(@pear.supermarket_name).to eq(@kings.name)
        expect(@rice.supermarket_name).to eq(@safeway.name)
        expect(@cheese.supermarket_name).to eq(@wholefood.name)
      end
    end

    describe ".customer_count" do
      it "returns the number of customers that have bought this item" do
        expect(@apple.customer_count).to eq(1)
        expect(@mango.customer_count).to eq(1)

        CustomerItem.create!(customer_id: @sue.id, item_id: @apple.id)
        CustomerItem.create!(customer_id: @frank.id, item_id: @apple.id)
        CustomerItem.create!(customer_id: @bob.id, item_id: @apple.id)

        CustomerItem.create!(customer_id: @bob.id, item_id: @mango.id)
        CustomerItem.create!(customer_id: @sue.id, item_id: @mango.id)

        expect(@apple.customer_count).to eq(4)
        expect(@mango.customer_count).to eq(3)
      end
    end
  end
end
