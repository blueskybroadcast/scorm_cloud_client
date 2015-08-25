class ScormCloudClient::Services::Debug < ScormCloudClient::BaseService
  API_METHOD_PREFIX = 'rustici.debug'

  def get_time
    execute_method('getTime')
  end

  def ping
    execute_method('ping')
  end
end
