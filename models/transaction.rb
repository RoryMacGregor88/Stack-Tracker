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

end
