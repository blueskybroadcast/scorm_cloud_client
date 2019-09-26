require 'spec_helper'

describe ScormCloudClient::BaseResponse do
  describe '#parse_result' do
    context 'when has error' do
      {
        100 => 'A general security error has occured, i.e. the security check has failed.',
        101 => 'The required appid parameter is missing.',
        102 => 'The required appid is invalid.',
        103 => 'The required sig parameter (request signature) is missing.',
        104 => 'The sig parameter is invalid (signature sent in the request does not match signature generated on the server)',
        105 => 'The required ts parameter (the UTC timestamp) is missing',
        106 => 'The required ts parameter is invalid (needs to be of the form yyyyMMddHHmmss)',
        107 => 'The passed ts parameter has expired (timestamp sent in request must be within certain amount of time within when server fulfills the request)',
        108 => 'An error has occurred in accessing the back end storage for authentication',
        200 => 'Invalid service call (the method parameter is missing or incorrect)',
        201 => 'Service unavailable',
        202 => 'Method not found',
        203 => 'A required parameter for the called method is missing from the request',
        204 => 'An invalid format parameter is specified (for now format is ignored, only XML is returned)',
        205 => 'Invalid method parameter value'
      }.each_pair do |code, message|
        context "when error code is #{code}" do
          subject { FactoryGirl.build(:base_response, specified_path: "errors/#{code}.xml") }

          it "raise ScormCloudClient::Exceptions::ScormCloudException" do
            expect { subject.parse_result(:some_method) }.to raise_error(ScormCloudClient::Exceptions::ScormCloudException, message)
          end
        end
      end
    end

    context 'when does not have error' do
      subject { FactoryGirl.build(:base_response, specified_path: 'course/exists.xml') }

      it 'sends method to parse response' do
        expect(subject).to receive(:some_method)
        subject.parse_result(:some_method)
      end
    end
  end
end
