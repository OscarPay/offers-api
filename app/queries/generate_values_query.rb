class GenerateValuesQuery
  def initialize
    @columns = %w[id price company label priority]
  end

  def call(values)
    formated_values = values.map do |value|
      format_value(value)
    end

    "SELECT * FROM (VALUES #{formated_values.join(', ')}) as i(#{@columns.join(', ')})"
  end

  private

  def format_value(value)
    "(#{value['id']}, #{value['price']}, '#{value['request_company']['name']}', 'from_api', 3)"
  end
end