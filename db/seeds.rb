require 'pg'
require 'active_record'
require 'pry'

Dir["../models/*.rb"].each do |file|
  require_relative file
end

# CREATE TABLE foods (
# 	id SERIAL PRIMARY KEY,
# 	name VARCHAR NOT NULL,
# 	price REAL NOT NULL,
# 	category VARCHAR,
# 	description TEXT,
# 	vegetarian BOOLEAN,
# 	gluten_free BOOLEAN,
# 	nut_free BOOLEAN,
# 	dairy_free BOOLEAN,
# 	created_at TIMESTAMP,
# 	updated_at TIMESTAMP
# );

# CREATE TABLE orders (
# 	id SERIAL PRIMARY KEY,
# 	food_id INT NOT NULL,
# 	party_id INT NOT NULL,
# 	comped BOOLEAN DEFAULT FALSE,
# 	created_at TIMESTAMP,
# 	updated_at TIMESTAMP
# );

# CREATE TABLE parties (
# 	id SERIAL PRIMARY KEY,
# 	people INT NOT NULL,
# 	paid BOOLEAN,
# 	table_id INT,
# 	employee_id INT,
# 	tip INT,
# 	created_at TIMESTAMP,
# 	updated_at TIMESTAMP
# );

# CREATE TABLE employees (
# 	id SERIAL PRIMARY KEY,
# 	name VARCHAR,
# 	password VARCHAR,
# 	authorization_token TEXT,
# 	created_at TIMESTAMP,
# 	updated_at TIMESTAMP
# );

ActiveRecord::Base.establish_connection(
	adapter: :postgresql,
	database: :restaurant,
	host: :localhost,
	port: 5432
)

# Populate foods table
[
	{
		name:'French Onion Soup',
		price:7,
		category:'Appetizer',
		description:'Onion soup with bread and melted cheese baked on top',
		vegetarian:true,
		gluten_free:false,
		nut_free:true,
		dairy_free:false,
	},
	{
		name:'Pepper Crusted Ahi Tuna Salad',
		price:13.50,
		category:'Appetizer',
		description:'Fresh greens with chopped tomatoes and peppers, pan seared pepper crusted tuna topped with a ginger-lime aioli',
		vegetarian:false,
		gluten_free:true,
		nut_free:true,
		dairy_free:true,
	},
	{
		name:'Braised Oxtail Ravioli',
		price:13.50,
		category:'Appetizer',
		description:'Homemade oxtail ravioli with brussels sprouts',
		vegetarian:false,
		gluten_free:false,
		nut_free:true,
		dairy_free:false,
	},
	{
		name:'Duck Confit',
		price:23,
		category:'Entree',
		description:'Confit duck leg with tumeric stewed fennel topped with a mango salsa',
		vegetarian:false,
		gluten_free:true,
		nut_free:true,
		dairy_free:true,
	},
	{
		name:'Surf N Turf',
		price:27,
		category:'Entree',
		description:'Pan seared pork tenderloin with seared scallops and a cauliflower mousse',
		vegetarian:false,
		gluten_free:true,
		nut_free:false,
		dairy_free:false,
	},
	{
		name:'Gnocchi in Fennel Cream sauce',
		price:21,
		category:'Entree',
		description:'Homemade gnocci in a cream of fennel',
		vegetarian:true,
		gluten_free:true,
		nut_free:false,
		dairy_free:false,
	},
	{
		name:'Creme Brulee',
		price:12,
		category:'Dessert',
		description:'Tradition creme brulee',
		vegetarian:true,
		gluten_free:true,
		nut_free:true,
		dairy_free:false,
	},
	{
		name:'Ice Cream Sundae',
		price:11,
		category:'Dessert',
		description:'Vanilla ice cream with dark chocolate sauce topped with sour cherries',
		vegetarian:true,
		gluten_free:true,
		nut_free:false,
		dairy_free:false,
	}
].each do |food|
	Food.create( food )
end

# Populate parties table

[
	{
		people:4,
		paid:false,
		table_id:1,
		employee_id:4,
		tip:0
	},
	{
		people:2,
		paid:false,
		table_id:2,
		employee_id:3,
		tip:0
	},
	{
		people:5,
		paid:false,
		table_id:3,
		employee_id:2,
		tip:0
	},
	{
		people:3,
		paid:false,
		table_id:4,
		employee_id:1,
		tip:0
	}
].each do |party|
	Party.create( party )
end

# Populate employees table

[
	{
		name:'Felix',
		password:123456
	},
	{
		name:'Jessie',
		password:98765
	},
	{
		name:'Claire',
		password:'qwerty'
	},
	{
		name:'Kevin',
		password:'poiuyt'
	}
].each do |employee|
		Employee.create( employee )
end

# # Populate orders table

[
	{
		food_id:1,
		party_id:1
	},
	{
		food_id:4,
		party_id:2
	},
	{
		food_id:2,
		party_id:4
	},
	{
		food_id:5,
		party_id:3
	},
	{
		food_id:3,
		party_id:3
	},
	{
		food_id:6,
		party_id:1
	},
	{
		food_id:7,
		party_id:2
	},
	{
		food_id:3,
		party_id:4
	},
	{
		food_id:7,
		party_id:1
	},
	{
		food_id:2,
		party_id:3
	},
	{
		food_id:5,
		party_id:1
	},
	{
		food_id:4,
		party_id:3
	},
	{
		food_id:1,
		party_id:4
	},
	{
		food_id:3,
		party_id:3
	}
].each do |order|
	Order.create( order )
end

