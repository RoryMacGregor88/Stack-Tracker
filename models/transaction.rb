require_relative( '../db/sql_runner.rb' )

class Transaction

  attr_reader :id, :date, :charge, :tag_id, :merchant_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @date = options['date'] if options['date']
    @charge = options['charge']
    @tag_id = options['tag_id']
    @merchant_id = options['merchant_id']
  end

  def save()
    sql = 'INSERT INTO transactions (charge, tag_id, merchant_id)
    VALUES ($1, $2, $3) RETURNING *'
    values = [@charge, @tag_id, @merchant_id]
    result = SqlRunner.run( sql, values )
    @id = result.first['id'].to_i
    @date = result.first['date']
  end

  def self.all()
    sql = 'SELECT * FROM transactions'
    result = SqlRunner.run( sql )
    return result.map { |hash| Transaction.new( hash ) }
  end

  def self.find( id )
    sql = 'SELECT * FROM transactions WHERE id = $1'
    values = [id]
    result = SqlRunner.run( sql, values ).first
    return Transaction.new( result )
  end

  def find_merchant_by_id()
    sql = 'SELECT * FROM merchants WHERE id = $1'
    values = [@merchant_id]
    result_hash = SqlRunner.run( sql, values ).first
    return Merchant.new( result_hash )
  end

  def find_tag_by_id()
    sql = 'SELECT * FROM tags WHERE id = $1'
    values = [@tag_id]
    result_hash = SqlRunner.run( sql, values ).first
    return Tag.new( result_hash )
  end

  def update()
    sql = 'UPDATE transactions SET (charge, tag_id, merchant_id) = ($1, $2, $3)
    WHERE id = $4'
    values = [@charge, @tag_id, @merchant_id, @id]
    SqlRunner.run( sql, values )
  end

  def self.delete( id )
    sql = 'DELETE FROM transactions WHERE id = $1'
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = 'DELETE FROM transactions'
    SqlRunner.run( sql )
  end

  def self.most_recent_transaction()
    result = []
    Transaction.all.each do |transaction|
      result << transaction
    end
    return result.last
  end

  def self.most_expensive_transaction()
    sql = 'SELECT * FROM transactions
          INNER JOIN tags
          ON transactions.tag_id = tags.id
          INNER JOIN merchants
          ON transactions.merchant_id = merchants.id
          ORDER BY charge DESC
          LIMIT 1'
    result = SqlRunner.run(sql).first
    return Transaction.new( result )
  end

  def self.filter_by_merchant( arg )
    merchant_name = arg.split.each{ |x| x.capitalize! }.join(' ')
    sql = 'SELECT * FROM transactions
          INNER JOIN tags
          ON transactions.tag_id = tags.id
          INNER JOIN merchants
          ON transactions.merchant_id = merchants.id
          WHERE name = $1'
    values = [merchant_name]
    result = SqlRunner.run(sql, values)
    return result.map{ |hash| Transaction.new( hash ) }
  end

  def self.filter_by_tag( tag_name )
    sql = 'SELECT * FROM transactions
          INNER JOIN merchants
          ON transactions.merchant_id = merchants.id
          INNER JOIN tags
          ON transactions.tag_id = tags.id
          WHERE category = $1'
    values = [tag_name]
    result = SqlRunner.run(sql, values)
    return result.map{ |hash| Transaction.new( hash ) }
  end

  def self.filter_by_date( date )
    sql = 'SELECT * FROM transactions
          INNER JOIN merchants
          ON transactions.merchant_id = merchants.id
          INNER JOIN tags
          ON transactions.tag_id = tags.id
          WHERE current_date = $1'
    values = [date]
    result = SqlRunner.run(sql, values)
    return result.map{ |hash| Transaction.new( hash ) }
  end

  def self.most_common_merchant()
    sql = 'SELECT name, COUNT(name) as FREQUENCY
          FROM transactions
          INNER JOIN merchants
          ON transactions.merchant_id = merchants.id
          INNER JOIN tags
          ON transactions.tag_id = tags.id
          GROUP BY name
          ORDER BY FREQUENCY DESC
          LIMIT 1'
    result_hash = SqlRunner.run(sql).first
    return Transaction.new( result_hash )
  end

  def number_of_transactions_for_merchant( merchant )
    result = Transaction.filter_by_merchant( merchant )
    return result.length()
  end

  def number_of_transactions_for_tag( tag )
    result = Transaction.filter_by_tag( tag )
    return result.length()
  end

  def self.total_money_spent_on_merchant( merchant )
    total = 0
    transactions = self.filter_by_merchant( merchant )
    transactions.each do |transaction|
    total += transaction.charge.to_f
    end
    return total
  end

  def total_money_spent_on_tag( tag )
    total = 0
    transactions = self.filter_by_tag( tag )
    transactions.each do |transaction|
    total += transaction.charge.to_f
    end
    return total
  end

  # def self.transactions_today( date )
  #   sql = 'SELECT * FROM transactions
  #         INNER JOIN merchants
  #         ON transactions.merchant_id = merchants.id
  #         INNER JOIN tags
  #         ON transactions.tag_id = tags.id
  #         WHERE current_date = $1'
  #   values = [date]
  #   result = SqlRunner.run(sql, values)
  #   return result.map{ |hash| Transaction.new( hash ) }
  # end

  # def self.filter_by_fragment( fragment )
  #   sql = "SELECT * FROM transactions
  #         INNER JOIN tags
  #         ON transactions.tag_id = tags.id
  #         INNER JOIN merchants
  #         ON transactions.merchant_id = merchants.id
  #         WHERE name = '%$1%'"
  #   values = [fragment]
  #   return SqlRunner.run(sql, values).first
  # end

end
