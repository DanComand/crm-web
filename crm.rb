require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'
require 'pry'

@@rolodex = Rolodex.new
@@rolodex.add_contact(Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer"))
@@rolodex.add_contact(Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO"))
@@rolodex.add_contact(Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder"))


get '/' do
	@crm_app_name = "CRManagr"
	@page_title = "Welcome"
	erb :index
end

get '/contacts' do
	@crm_app_name = "CRManagr"
	@page_title = "All contacts"
	@contacts = @@rolodex.contacts
	erb :contacts
end

get '/contacts/new' do
	@crm_app_name = "CRManagr"
  erb :new_contact
end

post '/contacts' do
  puts params
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  @@rolodex.add_contact(new_contact)
  redirect to('/contacts')
end

get "/show_contact/:id" do
  @contact = @@rolodex.find(params[:id])
  # binding.pry
  erb :show_contact
end

# $Rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))


