require 'digest/md5'
require 'nokogiri'

module ScormCloudClient
  module Exceptions; end
  module Responses; end
  module Services; end
end

require 'scorm_cloud_client/base_response'
require 'scorm_cloud_client/base_service'
require 'scorm_cloud_client/http_client'
require 'scorm_cloud_client/version'

require 'scorm_cloud_client/exceptions/scorm_cloud_exception'
require 'scorm_cloud_client/exceptions/unsupported_format_exception'

require 'scorm_cloud_client/services/course'
require 'scorm_cloud_client/services/debug'
require 'scorm_cloud_client/services/registration'

require 'scorm_cloud_client/responses/course'
require 'scorm_cloud_client/responses/debug'
require 'scorm_cloud_client/responses/registration'

class ScormCloudClient::Client
  SERVICE_MAPPING = {
    debug: ScormCloudClient::Services::Debug,
    course: ScormCloudClient::Services::Course,
    registration: ScormCloudClient::Services::Registration
  }.freeze
  TIMESTAMP_FORMAT = '%Y%m%d%H%M%S'.freeze
  CUSTOM_ERROR_CODE = 9999

  attr_reader :app_id, :secret_key, :http_client, *SERVICE_MAPPING.keys

  def initialize(app_id, secret_key)
    @app_id = app_id
    @secret_key = secret_key
    @http_client = ScormCloudClient::HTTPClient.new(self)

    initialize_serivices(SERVICE_MAPPING)
  end

  def secure_params(url_params)
    url_params[:appid] = @app_id
    url_params[:ts] = Time.now.utc.strftime(TIMESTAMP_FORMAT)

    raw = @secret_key + url_params.keys
                                  .sort { |a, b| a.to_s.downcase <=> b.to_s.downcase }
                                  .map { |k| "#{k}#{url_params[k]}" }
                                  .join

    url_params[:sig] = Digest::MD5.hexdigest(raw)
    url_params
  end

  private

  def initialize_serivices(services)
    services.each_pair do |service_name, service_class|
      instance_variable_set("@#{service_name}", service_class.new(http_client))
    end
  end
end
