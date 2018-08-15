require 'spec_helper'

describe ScormCloudClient::HTTPClient do
  it { expect { ScormCloudClient::HTTPClient::API_ENDPOINT }.to_not raise_error }
  it { expect(ScormCloudClient::HTTPClient::API_ENDPOINT).to eq 'https://cloud.scorm.com/api' }
end
