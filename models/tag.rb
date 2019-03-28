class Tag

  attr_accessor :id, :category

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @category = options['category']
  end

  def save()
    sql = 'INSERT INTO tags (category)
    VALUES ($1) RETURNING *'
    values = [@category]
    @id = SqlRunner.run( sql, values ).first['id'].to_i
  end

  def self.all()
    sql = 'SELECT * FROM tags'
    result = SqlRunner.run( sql )
    return result.map{ |hash| Tag.new( hash ) }
  end

  def self.find( id )
    sql = 'SELECT * FROM tags WHERE id = $1'
    values = [id]
    result = SqlRunner.run( sql, values ).first
    return Tag.new( result )
  end

  def update()
    sql = 'UPDATE tags SET category = $1
    WHERE id = $2'
    values = [@category, @id]
    SqlRunner.run( sql, values )
  end

  def transaction_count()
    sql = 'SELECT name FROM transactions
          INNER JOIN merchants
          ON transactions.merchant_id = merchants.id
          INNER JOIN tags
          ON transactions.tag_id = tags.id
          WHERE category = $1'
    values = [@category]
    result = SqlRunner.run( sql, values )
    return result.count
  end

  def total_tag_spending()
    total = 0
    sql = 'SELECT charge FROM transactions
		      INNER JOIN merchants
          ON transactions.merchant_id = merchants.id
          INNER JOIN tags
          ON transactions.tag_id = tags.id
          WHERE category = $1'
    values = [@category]
    result = SqlRunner.run( sql, values )
    result.each do | hash |
      total += hash['charge'].to_f
    end
    return total
  end

  def self.delete_all()
    sql = 'DELETE FROM tags'
    SqlRunner.run( sql )
  end

  def self.delete( id )
    sql = 'DELETE FROM tags WHERE id = $1'
    values = [id]
    SqlRunner.run( sql, values )
  end

end
