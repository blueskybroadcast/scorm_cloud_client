class ScormCloudClient::Responses::Registration < ScormCloudClient::BaseResponse
  COMPLETE_STATUSES = %w(complete unknown).freeze
  SUCCESS_STATUSES = %w(passed unknown).freeze

  def registration_result
    {
      registration_id: xml.at_xpath('//@regid').value,
      total_time: xml.at_xpath('//totaltime').text.to_i,
      score: xml.at_xpath('//score').text.to_i,
      complete: COMPLETE_STATUSES.include?(xml.at_xpath('//complete').text),
      success: SUCCESS_STATUSES.include?(xml.at_xpath('//success').text)
    }
  end

  private

  def create_registration
    xml.at_xpath('//rsp/success').name == 'success'
  end

  def exists
    xml.at_xpath('//result').text == 'true'
  end

  def test_registration_post_url
    xml.at_xpath('//rsp/success').name == 'success'
  end

  def get_registration_result
    registration_result
  end
end
