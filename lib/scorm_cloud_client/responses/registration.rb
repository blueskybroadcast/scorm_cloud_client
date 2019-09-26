require 'time'

class ScormCloudClient::Responses::Registration < ScormCloudClient::BaseResponse
  COMPLETE_STATUSES = %w(complete unknown).freeze
  SUCCESS_STATUSES = %w(passed unknown).freeze

  MINUTE_IN_SECONDS = 60
  HOUR_IN_SECONDS = MINUTE_IN_SECONDS * 60

  def registration_result
    report_format = xml.at_xpath('//@format').value

    case report_format
    when 'course' then parse_course_response
    when 'activity' then parse_activity_response
    when 'full' then parse_full_response
    else
      raise ScormCloudClient::Exceptions::UnsupportedFormatException.new(
        "Unsupported format: #{report_format}",
        xml.to_s
      )
    end
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

  def parse_course_response
    {
      registration_id: xml.at_xpath('//@regid').value,
      total_time: xml.at_xpath('//totaltime').text.to_i,
      score: xml.at_xpath('//score').text.to_i,
      complete: COMPLETE_STATUSES.include?(xml.at_xpath('//complete').text),
      success: SUCCESS_STATUSES.include?(xml.at_xpath('//success').text)
    }
  end

  def parse_activity_response
    {
      registration_id: xml.at_xpath('//@regid').value,
      total_time: parse_time(xml.at_xpath('//timeacrossattempts').text),
      score: xml.at_xpath('//score').text.to_i,
      complete: COMPLETE_STATUSES.include?(xml.at_xpath('//complete').text),
      success: SUCCESS_STATUSES.include?(xml.at_xpath('//success').text)
    }
  end

  def parse_full_response
    {
      registration_id: xml.at_xpath('//@regid').value,
      total_time: parse_time(xml.at_xpath('//timeacrossattempts').text),
      score: xml.at_xpath('//score_scaled').text.to_i,
      complete: xml.at_xpath('//completed').text.downcase == 'true',
      success: SUCCESS_STATUSES.include?(xml.at_xpath('//success_status').text.downcase)
    }
  end

  def parse_time(time)
    hours, minutes, seconds = time.split(':').map(&:to_f)

    (hours * HOUR_IN_SECONDS + minutes * MINUTE_IN_SECONDS + seconds).round
  end
end
