require 'sinatra'

get '/' do
	  @crm_app_name = "Dan's CRM"
	erb :index
end