class ScormCloudClient::Responses::Course < ScormCloudClient::BaseResponse

  private

  def import_course
    {
      success: xml.at_xpath('//@successful').text == 'true',
      title: xml.at_xpath('//title').text,
      message: xml.at_xpath('//message').text
    }
  end

  def import_course_async
    { token: xml.at_xpath('//token/id').text }
  end

  def get_course_list
    xml.xpath('//courselist/course').map do |course|
      {
        id: course.attributes['id'].value.to_i,
        title: course.attributes['title'].value,
        registrations: course.attributes['registrations'].value.to_i
      }
    end
  end

  def exists
    xml.at_xpath('//rsp/result').text == 'true'
  end

  def update_assets
    xml.at_xpath('//rsp/success').name == 'success'
  end

  def get_async_import_result
    status = xml.at_xpath('//status').text

    case status
    when 'finished' then parse_finished_async_import
    when 'error'    then parse_error_async_import
    when 'running'  then parse_running_async_import
    else raise_unknown_state_error
    end
  end

  def parse_finished_async_import
    {
      status: 'finished',
      success: xml.at_xpath('//@successful').text == 'true',
      title: xml.at_xpath('//title').text,
      message: xml.at_xpath('//message').text
    }
  end

  def parse_error_async_import
    {
      status: 'error',
      success: false,
      title: nil,
      message: xml.at_xpath('//error').text
    }
  end

  def parse_running_async_import
    {
      status: 'running',
      success: false,
      title: nil,
      message: xml.at_xpath('//message').text
    }
  end

  def raise_unknown_state_error
    error = ScormCloudClient::Exceptions::ScormCloudException.new(
      'Unknown state of async import',
      code: ScormCloudClient::Client::CUSTOM_ERROR_CODE,
      xml: xml.to_xml
    )

    raise error
  end
end
