class ScormCloudClient::BaseResponse
  attr_reader :xml

  def initialize(xml_response)
    @xml = Nokogiri::XML(xml_response)
  end

  def parse_result(method_name)
    if has_error?
      raise_scorm_cloud_error
    else
      send(method_name)
    end
  end

  private

  def has_error?
    xml.at_xpath('//rsp/err')
  end

  def raise_scorm_cloud_error
    error_element = xml.at_xpath('//rsp/err')

    error_message = error_element.attributes['msg'].value
    error_code = error_element.attributes['code'].value.to_i

    raise ScormCloudClient::Exceptions::ScormCloudException.
      new(error_message, code: error_code, xml: xml.to_xml)
  end
end
