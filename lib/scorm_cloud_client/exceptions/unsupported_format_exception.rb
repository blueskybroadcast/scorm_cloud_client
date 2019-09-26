class ScormCloudClient::Exceptions::UnsupportedFormatException < StandardError
  attr_reader :xml

  def initialize(message, xml)
    super(message)

    @xml = xml
  end
end

