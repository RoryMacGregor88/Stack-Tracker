require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/transaction' )
also_reload( '../models/*' )

get '/transactions' do
  @transactions = Transaction.all()
  erb( :"transactions/index" )
end

# get '/transactions' do
#   erb( :"transactions/index" )
# end
