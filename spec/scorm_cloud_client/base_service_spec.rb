require 'spec_helper'

describe ScormCloudClient::BaseService do
  subject { FactoryGirl.build(:base_service) }

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
