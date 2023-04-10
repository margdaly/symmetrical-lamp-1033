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
  end
end
