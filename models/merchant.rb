class Merchant

  attr_accessor :id, :name

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = 'INSERT INTO merchants (name) VALUES ($1) RETURNING *'
    values = [@name]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM merchants'
    SqlRunner.run(sql)
  end

end
