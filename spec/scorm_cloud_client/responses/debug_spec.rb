require 'spec_helper'

describe ScormCloudClient::Responses::Debug do
  describe '#ping' do
    subject { FactoryGirl.build(:debug_response, specified_path: 'debug/ping.xml') }
    let(:result) { 'pong' }

    it 'returns "pong"' do
      expect(subject.send(:ping)).to be_eql(result)
    end
  end

  describe '#get_time' do
    subject { FactoryGirl.build(:debug_response, specified_path: 'debug/get_time.xml') }
    let(:result) { { time_zone: 'UTC', time: '20150825195305' } }

    it 'returns info about current time' do
      expect(subject.send(:get_time)).to be_eql(result)
    end
  end
end
