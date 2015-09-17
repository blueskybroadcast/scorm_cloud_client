class ScormCloudClient::Exceptions::ScormCloudException < StandardError
  attr_reader :code, :xml

  def initialize(message, options)
    super(message)

    @code = options[:code]
    @xml = options[:xml]
  end
end
