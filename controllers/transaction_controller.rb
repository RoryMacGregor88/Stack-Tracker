require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/transaction' )
also_reload( '../models/*' )

get '/transactions' do
  @transactions = Transaction.all()
  erb( :"transactions/index" )
end

get '/transactions/new' do
  @tags = Tag.all()
  @merchants = Merchant.all()
  erb( :'transactions/new' )
end
