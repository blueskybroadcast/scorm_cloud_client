require 'spec_helper'

describe ScormCloudClient::Responses::Course do
  describe '#exists' do
    subject { FactoryGirl.build(:course_response, specified_path: 'course/exists.xml') }
    let(:result) { true }

    it 'returns result of exists call' do
      expect(subject.send(:exists)).to be_eql(result)
    end
  end

  describe '#get_course_list' do
    subject { FactoryGirl.build(:course_response, specified_path: 'course/get_course_list.xml') }
    let(:result) do
      [
        { id: 1, title: 'Golf Explained - Run-time Basic Calls', registrations: 0 }
      ]
    end

    it 'returns info courses' do
      expect(subject.send(:get_course_list)).to be_eql(result)
    end
  end
end
