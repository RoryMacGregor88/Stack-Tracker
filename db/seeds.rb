require( 'pry-byebug' )
require_relative( '../models/tag.rb' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/transaction.rb' )

tag1 = Tag.new({
  'category' => 'groceries'
  })
tag1.save()

merchant1 = Merchant.new({
  'name' => 'Tesco'
  })
merchant1.save()

transaction1 = Transaction.new({
  'merchant_id' => merchant1.id,
  'tag_id' => tag1.id,
  'charge' => '43.21'
  })
transaction1.save()
