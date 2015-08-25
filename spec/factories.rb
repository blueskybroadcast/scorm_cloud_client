FactoryGirl.define do
  factory :scorm_client, class: ScormCloudClient::Client do
    skip_create

    app_id 'app_id'
    secret_key 'secret_key'

    initialize_with { new(app_id, secret_key) }
  end

  factory :http_client, class: ScormCloudClient::HTTPClient do
    skip_create

    scorm_client

    initialize_with { new(scorm_client) }
  end

  factory :base_response, class: ScormCloudClient::BaseResponse do
    skip_create

    xml './spec/support/fixtures/'
    ignore do
      specified_path ''
    end

    initialize_with { new(File.read(xml + specified_path)) }

    factory :course_response, class: ScormCloudClient::Responses::Course
    factory :debug_response, class: ScormCloudClient::Responses::Debug
    factory :registration_response, class: ScormCloudClient::Responses::Registration
    factory :reporting_response, class: ScormCloudClient::Responses::Reporting
  end

  factory :base_service, class: ScormCloudClient::BaseService do
    skip_create

    http_client

    initialize_with { new(http_client) }

    factory :course_service, class: ScormCloudClient::Services::Course
    factory :debug_service, class: ScormCloudClient::Services::Debug
    factory :registration_service, class: ScormCloudClient::Services::Registration
    factory :reporting_service, class: ScormCloudClient::Services::Reporting
  end
end
