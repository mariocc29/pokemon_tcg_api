module Pokemon
  class Service

    def initialize(endpoint)
      @uri = URI("#{Rails.application.config.pokemon[:url]}/#{endpoint}")
    end

    def get
      response = connect do |http|
        request = Net::HTTP::Get.new @uri
        request['accept'] = 'application/json'
        http.request request
      end

      JSON.parse(response.read_body)
    end

    private

    def connect
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      yield http
    end
  end
end