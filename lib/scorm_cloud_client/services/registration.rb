class ScormCloudClient::Services::Registration < ScormCloudClient::BaseService
  API_METHOD_PREFIX = 'rustici.registration'.freeze

  def create_registration(params)
    execute_method('createRegistration', params)
  end

  def launch(params)
    params.merge!(method: full_method('launch'))
    http_client.prepare_url(params)
  end

  def exists?(params)
    execute_method('exists', params)
  end

  def get_registration_result(params)
    execute_method('getRegistrationResult', params)
  end

  def test_registration_post_url(params)
    execute_method('testRegistrationPostUrl', params)
  end
end
