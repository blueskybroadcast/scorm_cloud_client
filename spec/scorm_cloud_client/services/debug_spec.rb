require 'spec_helper'

describe ScormCloudClient::Services::Debug do
  subject { FactoryGirl.build(:debug_service) }

  context 'API methods' do
    before { allow(subject).to receive(:execute_method) }

    describe '#ping' do
      it 'executes method "ping"' do
        expect(subject).to receive(:execute_method).with('ping')
        subject.ping
      end
    end

    describe '#get_time' do
      it 'executes method "getTime"' do
        expect(subject).to receive(:execute_method).with('getTime')
        subject.get_time
      end
    end
  end

  it_behaves_like 'service', prefix: described_class::API_METHOD_PREFIX, methods: {}
end
