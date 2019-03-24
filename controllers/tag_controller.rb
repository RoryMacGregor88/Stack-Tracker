require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/tag.rb' )
also_reload( '../models/*' )

get '/tags' do
  @tags = Tag.all()
  erb( :'tags/index' )
end
