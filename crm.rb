require_relative 'rolodex'
# require_relative 'contact'
require 'sinatra'
require 'pry'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

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

# Generates the Edit Form
get "/edit_contact/:id" do
	@contact = Contact.get(params[:id].to_i)
  erb :edit_contact
end

# Handles the PUT request from the Edit Form
put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)

  if @contact
  

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

