require 'spec_helper'

describe ScormCloudClient::Client do
  subject { FactoryGirl.build(:scorm_client) }

  describe '#initialize_serivices' do
    ScormCloudClient::Client::SERVICE_MAPPING.each_pair do |service_name, service_klass|
      it "defines #{service_name} service" do
        service = subject.public_send(service_name)

        expect(service).not_to be_nil
        expect(service).to be_kind_of service_klass
      end
    end
  end

  describe '#secure_params' do
    let(:url_params) { { key: :value } }
    let(:signature) { 'test_signature' }
    let(:time_now) { Time.now.utc }
    let(:result) { { key: :value, appid: subject.app_id, sig: signature, ts: time_now.strftime('%Y%m%d%H%M%S') } }

    before do
      allow(Digest::MD5).to receive(:hexdigest) { signature }
      allow(Time.now).to receive(:utc) { time_now }
    end

    it 'returns params with signature' do
      expect(subject.send(:secure_params, url_params)).to be_eql result
    end
  end
end
