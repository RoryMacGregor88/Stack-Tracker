require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/transaction.rb' )
also_reload( '../models/*' )

get '/transactions' do
  @name = 'Johnny cage'
  erb( :"transactions/index" )
end
