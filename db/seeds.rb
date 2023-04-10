CustomerItem.delete_all
Customer.delete_all
Item.delete_all
Supermarket.delete_all

@safeway = Supermarket.create!(name: "Safe Way", location: "Platt Park")
@kings = Supermarket.create!(name: "King Soopers", location: "Cap Hill")
@wholefood = Supermarket.create!(name: "Whole Foods", location: "So. Broadway")

@oats = @safeway.items.create!(name: "Oats", price: 3)
@rice = @safeway.items.create!(name: "Oats", price: 2)

@pear = @kings.items.create!(name: "Pear", price: 2)
@apple = @kings.items.create!(name: "Apple", price: 1)

@cheese = @wholefood.items.create!(name: "Cheese", price: 5)
@mango = @wholefood.items.create!(name: "Mango", price: 4)


@frank = Customer.create!(name: "Frank")
@sue = Customer.create!(name: "Sue")
@bob = Customer.create!(name: "Bob")

CustomerItem.create!(customer_id: @frank.id, item_id: @oats.id)
CustomerItem.create!(customer_id: @frank.id, item_id: @rice.id)
CustomerItem.create!(customer_id: @frank.id, item_id: @pear.id)

CustomerItem.create!(customer_id: @sue.id, item_id: @apple.id)
CustomerItem.create!(customer_id: @sue.id, item_id: @cheese.id)
CustomerItem.create!(customer_id: @sue.id, item_id: @mango.id)
