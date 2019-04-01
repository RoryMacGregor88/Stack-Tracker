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

tag4 = Tag.new({
  'category' => 'guitar parts'
  })
tag4.save()

tag5 = Tag.new({
  'category' => 'music gear'
  })
tag5.save()

tag6 = Tag.new({
  'category' => 'travel'
  })
tag6.save()

tag7 = Tag.new({
  'category' => 'fuel'
  })
tag7.save()

tag8 = Tag.new({
  'category' => 'household'
  })
tag8.save()

tag9 = Tag.new({
  'category' => 'training'
  })
tag9.save()

tag10 = Tag.new({
  'category' => 'clothes'
  })
tag10.save()


merchant1 = Merchant.new({
  'name' => 'DJ Alexander'
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

merchant4 = Merchant.new({
  'name' => 'eBay'
  })
merchant4.save()

merchant5 = Merchant.new({
  'name' => 'Merchant City Music'
  })
merchant5.save()

merchant6 = Merchant.new({
  'name' => 'BP Garage'
  })
merchant6.save()

merchant7 = Merchant.new({
  'name' => 'Scotrail'
  })
merchant7.save()

merchant8 = Merchant.new({
  'name' => 'various'
  })
merchant8.save()

merchant9 = Merchant.new({
  'name' => 'CEX'
  })
merchant9.save()

merchant10 = Merchant.new({
  'name' => 'Wetherspoons'
  })
merchant10.save()


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
  'merchant_id' => merchant4.id,
  'tag_id' => tag4.id,
  'charge' => '399.99'
  })
transaction4.save()

transaction5 = Transaction.new({
  'merchant_id' => merchant5.id,
  'tag_id' => tag5.id,
  'charge' => '26.98'
  })
transaction5.save()

transaction6 = Transaction.new({
  'merchant_id' => merchant2.id,
  'tag_id' => tag2.id,
  'charge' => '11.33'
  })
transaction6.save()

transaction7 = Transaction.new({
  'merchant_id' => merchant10.id,
  'tag_id' => tag3.id,
  'charge' => '15.98'
  })
transaction7.save()

transaction8 = Transaction.new({
  'merchant_id' => merchant9.id,
  'tag_id' => tag3.id,
  'charge' => '15.98'
  })
transaction8.save()

transaction9 = Transaction.new({
  'merchant_id' => merchant4.id,
  'tag_id' => tag9.id,
  'charge' => '88.21'
  })
transaction9.save()

transaction10 = Transaction.new({
  'merchant_id' => merchant2.id,
  'tag_id' => tag8.id,
  'charge' => '16.42'
  })
transaction10.save()

merchants = Merchant.all()
tags = Tag.all()

100.times do
  transaction = Transaction.new({
    'merchant_id' => merchants.sample.id,
    'tag_id' => tags.sample.id,
    'charge' => rand(1.1..99.9).to_f.round(2)
    })
  transaction.save()
end

binding.pry
nil
