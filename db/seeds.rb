require( 'pry-byebug' )
require_relative( '../models/tag.rb' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/transaction.rb' )

Transaction.delete_all()
Merchant.delete_all()
Tag.delete_all()

tag1 = Tag.new({
  'category' => 'rent'
  })
tag1.save()

tag2 = Tag.new({
  'category' => 'groceries'
  })
tag2.save()

tag3 = Tag.new({
  'category' => 'entertainment'
  })
tag3.save()

merchant1 = Merchant.new({
  'name' => 'Edinburgh Council'
  })
merchant1.save()

merchant2 = Merchant.new({
  'name' => 'Tesco'
  })
merchant2.save()

merchant3 = Merchant.new({
  'name' => 'Chanter'
  })
merchant3.save()

transaction1 = Transaction.new({
  'merchant_id' => merchant1.id,
  'tag_id' => tag1.id,
  'charge' => '563.50'
  })
transaction1.save()

transaction2 = Transaction.new({
  'merchant_id' => merchant2.id,
  'tag_id' => tag2.id,
  'charge' => '43.21'
  })
transaction2.save()

transaction3 = Transaction.new({
  'merchant_id' => merchant3.id,
  'tag_id' => tag3.id,
  'charge' => '18.60'
  })
transaction3.save()

transaction4 = Transaction.new({
  'merchant_id' => merchant3.id,
  'tag_id' => tag3.id,
  'charge' => '999'
  })
transaction4.save()

result = Transaction.filter_by_merchant( 'Chanter' )

binding.pry
nil
