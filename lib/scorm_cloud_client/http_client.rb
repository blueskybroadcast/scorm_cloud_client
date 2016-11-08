require 'rest-client'

class ScormCloudClient::HTTPClient
  attr_reader :client, :scorm_client

  API_ENDPOINT = 'http://cloud.scorm.com/api'.freeze

  def initialize(scorm_client)
    @scorm_client = scorm_client
    @client = RestClient
  end

  def call(url_params, request_params, http_method = :get)
    response = client.public_send(http_method, prepare_url(url_params), request_params)
    response.body
  end

  def stringify_params(params)
    params.each_with_object([]) { |(key, value), memo| memo << "#{key}=#{value}" }
          .join('&')
  end

  def prepare_url(url_params)
    secured_params = scorm_client.secure_params(url_params)
    "#{API_ENDPOINT}?#{stringify_params(secured_params)}"
  end
end
