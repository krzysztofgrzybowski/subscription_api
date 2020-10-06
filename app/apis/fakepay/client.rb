module Fakepay
  class Client
    ENDPOINT = 'https://www.fakepay.io'.freeze

    def payment_with_card(params = {})
      params = if params[:token]
                 params.slice(:amount, :token)
               else
                 params.slice(:amount, :card_number, :cvv, :expiration_month, :expiration_year, :zip_code)
               end
      request(
        http_method: :post,
        endpoint: 'purchase',
        params: params
      )
    end

    private

    def client
      @client ||= Faraday.new(ENDPOINT) do |c|
        c.request :url_encoded
        c.headers['Authorization'] = "Token token=#{ENV['FAKEPAY_API_KEY']}"
      end
    end

    def request(http_method:, endpoint:, params:)
      JSON.parse(
        client.public_send(http_method, endpoint, params).body
      )
    end
  end
end
