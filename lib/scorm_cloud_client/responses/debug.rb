class ScormCloudClient::Responses::Debug < ScormCloudClient::BaseResponse
  def ping
    xml.xpath('//rsp/pong').first.name
  end

  def get_time
    {
      time: xml.xpath('//currenttime').first.text,
      time_zone: xml.xpath('//@tz').first.value
    }
  end
end
