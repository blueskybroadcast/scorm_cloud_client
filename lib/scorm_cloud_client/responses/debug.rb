class ScormCloudClient::Responses::Debug < ScormCloudClient::BaseResponse

  private

  def ping
    xml.at_xpath('//rsp/pong').name
  end

  def get_time
    {
      time: xml.at_xpath('//currenttime').text,
      time_zone: xml.at_xpath('//@tz').value
    }
  end
end
