class ScormCloudClient::BaseService
  attr_reader :http_client

  def initialize(http_client)
    @http_client = http_client
  end

  def execute_method(api_method_name, url_params = {}, request_params = {})
    url_params.merge!(method: full_method(api_method_name))
    xml = http_client.call(url_params, request_params, http_method(api_method_name))
    parse_response(xml, api_method_name)
  end

  private

  def full_method(api_method_name)
    "#{self.class::API_METHOD_PREFIX}.#{api_method_name}"
  end

  def http_method(api_method_name)
    specified_http_mehods[api_method_name.to_sym] || :get
  end

  def parse_response(xml, method)
    klass_name = self.class.name.split('::').last
    method_name = method.gsub(/(.)([A-Z])/,'\1_\2').downcase
    ScormCloudClient::Responses.const_get(klass_name).new(xml).parse_result(method_name)
  end

  def specified_http_mehods
    if self.class.constants.include?(:SPECIFIED_HTTP_MEHODS)
      self.class::SPECIFIED_HTTP_MEHODS
    else
      {}
    end
  end
end
