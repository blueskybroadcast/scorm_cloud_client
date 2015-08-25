class ScormCloudClient::Responses::Registration < ScormCloudClient::BaseResponse
  def create_registration
    xml.xpath('//rsp/success').first.name == 'success'
  end

  def exists
    xml.xpath('//result').first.text == 'true'
  end

  def test_registration_post_url
    xml.xpath('//rsp/success').first.name == 'success'
  end

  def get_registration_result
  end

  def registration_result
    {
      registration_id: xml.xpath('//@regid').first.value,
      total_time: xml.xpath('//totaltime').first.text.to_i,
      score: xml.xpath('//score').first.text.to_i,
      complete: %w(complete unknown).include?(xml.xpath('//complete').first.text),
      success: %w(passed unknown).include?(xml.xpath('//success').first.text)
    }
  end
end
