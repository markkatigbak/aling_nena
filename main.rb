require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
	@item = Item.new
	@item.name = params[:name]
	@item.price = params[:price]
	@item.quantity = params[:quantity]
	@item.sold = 0
	@item.save
 	redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION

get '/about' do
  erb :about
end

get '/' do
  products = Item.all
  @products = products.sample(10)
  erb :index
end

get '/products' do
  @products = Item.all
  erb :products
end

get '/buy/:id' do
  @product = Item.find(params[:id])
  erb :buy
end

post '/checkout' do
  thousands = params[:thousands].to_i
  five_hundreds = params[:five_hundreds].to_i
  hundreds = params[:hundreds].to_i

  fifties = params[:fifties].to_i
  twenties = params[:twenties].to_i
  tens = params[:tens].to_i
  fives = params[:fives].to_i
  ones = params[:ones].to_i
  quantity = params[:quantity].to_i
  product = Item.find(params[:id])
  price = product.price.to_i
  cost = price * quantity
  @p = product
  @cost = cost
  money = (ones * 1) + (fives * 5) + (tens * 10) + (twenties * 20) + (fifties * 50) + (hundreds * 100) + (five_hundreds * 500)  + (thousands * 1000)
  @money = money

  x = MoneyCalculator.new(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
  
  
  change = x.change(cost)
  @thousands = change[:thousands]
  @fh = change[:five_hundreds]
  @hundreds = change[:hundreds]
  @fifties = change[:fifties]
  @twenties = change[:twenties]
  @fives = change[:fives]
  @tens = change[:tens]
  @ones = change[:ones]

  @total = @thousands  * 1000 + @fh * 500 + @hundreds * 100  + @fifties*50 + @twenties*20 + @fives*5 + @tens*10 + @ones*1
  if (@cost > @money)
	erb :failure
  else
  product.update_attributes!(
    quantity: product.quantity - quantity,
    sold: product.sold + quantity
  )


  erb :checkout
end
end