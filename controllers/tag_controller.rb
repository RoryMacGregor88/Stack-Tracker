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

# post '/tags/:id/delete' do
#
# end
