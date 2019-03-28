class Merchant

  attr_accessor :id, :name, :total_money, :count

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @count = transaction_count()
    @total_money = 0
  end

  def save()
    sql = 'INSERT INTO merchants (name)
    VALUES ($1) RETURNING *'
    values = [@name]
    @id = SqlRunner.run( sql, values ).first['id'].to_i
  end

  def self.all()
    sql = 'SELECT * FROM merchants'
    result = SqlRunner.run( sql )
    return result.map{ |hash| Merchant.new( hash ) }
  end

  def self.find( id )
    sql = 'SELECT * FROM merchants WHERE id = $1'
    values = [id]
    result = SqlRunner.run( sql, values ).first
    return Merchant.new( result )
  end

  def update()
    sql = 'UPDATE merchants SET name = $1
    WHERE id = $2'
    values = [@name, @id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = 'DELETE FROM merchants'
    SqlRunner.run( sql )
  end

  def transaction_count()
    sql = 'SELECT name FROM transactions
          INNER JOIN merchants
          ON transactions.merchant_id = merchants.id
          INNER JOIN tags
          ON transactions.tag_id = tags.id
          WHERE name = $1'
    values = [@name]
    result = SqlRunner.run( sql, values )
    return result.count
  end

  def total_merchant_spending()
    total = 0
    sql = 'SELECT charge FROM transactions
		      INNER JOIN merchants
          ON transactions.merchant_id = merchants.id
          INNER JOIN tags
          ON transactions.tag_id = tags.id
          WHERE name = $1'
    values = [@name]
    result = SqlRunner.run( sql, values )
    result.each do | hash |
      total += hash['charge'].to_f
    end
    return total
  end

  def self.delete( id )
    sql = 'DELETE FROM merchants WHERE id = $1'
    values = [id]
    SqlRunner.run( sql, values )
  end

end
