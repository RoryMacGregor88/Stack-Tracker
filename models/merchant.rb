class Merchant

  attr_accessor :id, :name

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
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

  def self.delete( id )
    sql = 'DELETE FROM merchants WHERE id = $1'
    values = [id]
    SqlRunner.run( sql, values )
  end

end
