require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex= Rolodex.new



get '/' do
	@crm_app_name = "CRManagr"
	@page_title = "Welcome"
	erb :index
end

get '/contacts' do
	@crm_app_name = "CRManagr"
	@page_title = "All contacts"
	@contacts = []
	@contacts << Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer")
	@contacts << Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO")
	@contacts << Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder")

	erb :contacts
end

get '/contacts/new' do
	@crm_app_name = "CRManagr"
  erb :new_contact
end

post '/contacts' do
  puts params
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)
  redirect to('/contacts')
end

get '/contacts/1000' do
  "Hello World"
end

