class ScormCloudClient::BaseResponse
  attr_reader :xml

  def initialize(xml_response)
    @xml = Nokogiri::XML(xml_response)
  end
end
