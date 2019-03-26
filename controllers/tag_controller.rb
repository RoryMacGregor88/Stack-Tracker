require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/tag.rb' )
also_reload( '../models/*' )

get '/tags' do
  @tags = Tag.all()
  erb( :'tags/index' )
end

get '/tags/new' do
  @tags = Tag.all()
  erb( :'tags/new' )
end

get '/tags/show' do
  @tags = Tag.all()
  erb( :'tags/show' )
end

post '/tags' do
  tag = Tag.new( params )
  tag.save()
  redirect to( '/tags' )
end

post '/tags/:id/delete' do
 Tag.delete( params[:id ] )
 redirect to ( '/tags' )
end

get '/tags/:id/update' do
  @tag = Tag.find( params[:id] )
  @tags = Tag.all()
  erb( :'/tags/update' )
end

post '/tags/:id' do
  tag = Tag.new( params )
  tag.update()
  redirect to "/tags"
end
