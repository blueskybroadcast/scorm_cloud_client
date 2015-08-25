class ScormCloudClient::Services::Course < ScormCloudClient::BaseService
  API_METHOD_PREFIX = 'rustici.course'
  SPECIFIED_HTTP_MEHODS = { importCourse: :post, updateAssets: :post }.freeze

  def import_course(file, params)
    execute_method('importCourse', params, file: file)
  end

  def get_course_list
    execute_method('getCourseList')
  end

  def exists(params)
    execute_method('exists', params)
  end

  def update_assets(file, params)
    execute_method('updateAssets', params, file: file)
  end
end
