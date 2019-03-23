require_relative( '../db/sql_runner.rb' )

class Transaction

  attr_accessor :id, :date, :charge, :tag_id, :merchant_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @date = options['date'] if options['date']
    @charge = options['charge']
    @tag_id = options['tag_id']
    @merchant_id = options['merchant_id']
  end

end
