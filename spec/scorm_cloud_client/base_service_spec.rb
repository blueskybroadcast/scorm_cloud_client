require 'spec_helper'

describe ScormCloudClient::BaseService do
  subject { FactoryGirl.build(:base_service) }

  describe '#full_method' do
    before { allow(subject).to receive(:api_method_prefix).and_return('prefix') }

    it 'returns concatenation of prefix and method' do
      expect(subject.send(:full_method, 'some_method')).to be_eql 'prefix.some_method'
    end
  end

  describe '#http_method' do
    context 'when method is specified' do
      before { allow(subject).to receive(:specified_http_mehods).and_return(specified: :post) }

      it { expect(subject.send(:http_method, :specified)).to be_eql :post }
    end

    context 'when method is not specified' do
      before { allow(subject).to receive(:specified_http_mehods).and_return({}) }

      it { expect(subject.send(:http_method, :value)).to be_eql :get }
    end
  end
end
