require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/transaction.rb' )
also_reload( '../models/*' )

get '/transactions' do
  @transactions = Transaction.all()
  @most_recent = Transaction.most_recent_transaction()
  @most_expensive = Transaction.most_expensive_transaction()
  erb( :'transactions/index' )
end

get '/transactions/new' do
  @tags = Tag.all()
  @merchants = Merchant.all()
  erb( :'transactions/new' )
end

post '/transactions' do
  transaction = Transaction.new( params )
  transaction.save()
  redirect to('/transactions')
end

post '/transactions/:id/delete' do
  Transaction.delete( params[:id] )
  redirect to( '/transactions' )
end

get '/transactions/:id/update' do
  @transaction = Transaction.find( params[:id] )
  @transactions = Transaction.all()
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb( :'/transactions/update' )
end

post '/transactions/:id' do
  transaction = Transaction.new( params )
  transaction.update()
  redirect to "/transactions"
end

post '/transactions/:id' do
  function( params[:date] )
end

get '/transactions/filter' do
  @filtered_merchants = Transaction.filter_by_merchant( params[:name] )
  @filtered_dates = Transaction.transactions_today( params[:date] )
  erb( :'/transactions/filter' )
end
