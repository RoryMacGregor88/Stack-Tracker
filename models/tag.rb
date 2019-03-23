class Tag

  attr_accessor :id, :category

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @category = options['category']
  end

  def save()
      sql = 'INSERT INTO tags (category) VALUES ($1) RETURNING *'
      values = [@category]
      @id = SqlRunner.run(sql, values).first['id'].to_i
    end

end
