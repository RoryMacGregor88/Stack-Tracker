require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/transaction.rb' )
also_reload( '../models/*' )

get '/transactions' do
  @transactions = Transaction.all()
  @most_recent = Transaction.most_recent_transaction()
  @most_expensive = Transaction.most_expensive_transaction()
  @most_common = Transaction.most_common_merchant()
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

get '/transactions/merchant_filter' do
  @filtered_merchants = Transaction.filter_by_merchant( params[:name] )
  erb( :'/transactions/merchant_filter' )
end

get '/transactions/tag_filter' do
  @filtered_tags = Transaction.filter_by_tag( params[:tag] )
  erb( :'/transactions/tag_filter' )
end

get '/transactions/date_filter' do
  @filtered_dates = Transaction.filter_by_date( params[:date] )
  erb( :'/transactions/date_filter' )
end
