class ScormCloudClient::Responses::Course < ScormCloudClient::BaseResponse
  def import_course
    {
      success: xml.xpath('//@successful').first.text == 'true',
      title: xml.xpath('//title').first.text,
      message: xml.xpath('//message').first.text
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
    xml.xpath('//rsp/result').text == 'true'
  end

  def update_assets
    xml.xpath('//rsp/success').first.name == 'success'
  end
end
