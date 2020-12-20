class IntrosService

  def self.call
    response = Faraday.get('https://bravado.co/api/api/opportunity/intros.json')
    JSON.parse(response.body.force_encoding(Rails.application.config.encoding.to_s))
  end

end