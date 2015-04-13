require_relative 'rolodex'
# require_relative 'contact'
require 'sinatra'
require 'pry'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

# @@rolodex = Rolodex.new
# @@rolodex.add_contact(Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer"))
# @@rolodex.add_contact(Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO"))
# @@rolodex.add_contact(Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder"))

# DataMapper.setup(:default, "sqlite3:database.sqlite")

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String

end

DataMapper.finalize
DataMapper.auto_upgrade!


get '/' do
	@crm_app_name = "CRManagr"
	@page_title = "Welcome"
	erb :index
end

get '/contacts' do
	@crm_app_name = "CRManagr"
	@page_title = "All contacts"
	@contacts = Contact.all
	erb :contacts
end

get '/contacts/new' do
	@crm_app_name = "CRManagr"
  erb :new_contact
end

post '/contacts' do
  puts params
  new_contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note], )

  redirect to('/contacts')
end

get "/show_contact/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

# $Rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))

# Generates the Edit Form
get "/edit_contact/:id" do
	@contact = Contact.get(params[:id].to_i)
  erb :edit_contact
end

# Handles the PUT request from the Edit Form
put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  # puts @contact.inspect
  # puts params.inspect
  if @contact
    # @contact.first_name = params[:first_name]
    # @contact.last_name = params[:last_name]
    # @contact.email = params[:email]
    # @contact.note = params[:note]

    @contact.update(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note], )
    
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/delete" do
  @contact = Contact.get(params[:id])
  if @contact
    @contact.destroy
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end

end

