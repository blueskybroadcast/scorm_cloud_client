class ScormCloudClient::Responses::Course < ScormCloudClient::BaseResponse

  private

  def import_course
    {
      success: xml.at_xpath('//@successful').text == 'true',
      title: xml.at_xpath('//title').text,
      message: xml.at_xpath('//message').text
    }
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
end
