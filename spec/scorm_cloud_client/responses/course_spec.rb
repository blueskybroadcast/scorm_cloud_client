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

  describe '#import_course_async' do
    subject { FactoryGirl.build(:course_response, specified_path: 'course/import_course_async.xml') }
    let(:result) do
      { token: 'superman_2128' }
    end

    it 'returns import token' do
      expect(subject.send(:import_course_async)).to be_eql(result)
    end
  end

  describe '#get_async_import_result' do
    context 'when process is finished' do
      subject { FactoryGirl.build(:course_response, specified_path: 'course/get_async_import_result/finished.xml') }
      let(:result) do
        {
          status: 'finished',
          success: true,
          title: 'Photoshop Example -- Competency',
          message: 'Import Successful'
        }
      end

      it 'returns info about finished import' do
        expect(subject.send(:get_async_import_result)).to be_eql(result)
      end
    end

    context 'when process is still running' do
      subject { FactoryGirl.build(:course_response, specified_path: 'course/get_async_import_result/running.xml') }
      let(:result) do
        {
          status: 'running',
          success: false,
          title: nil,
          message: 'Unpacking Course Files...'
        }
      end

      it 'returns info about running import' do
        expect(subject.send(:get_async_import_result)).to be_eql(result)
      end
    end

    context 'when process is failed' do
      subject { FactoryGirl.build(:course_response, specified_path: 'course/get_async_import_result/error.xml') }
      let(:result) do
        {
          status: 'error',
          success: false,
          title: nil,
          message: 'Custom error message'
        }
      end

      it 'returns info about failed import' do
        expect(subject.send(:get_async_import_result)).to be_eql(result)
      end
    end

    context 'when unknown state was returned' do
      subject { FactoryGirl.build(:course_response, specified_path: 'course/get_async_import_result/unknown_state.xml') }

      it 'raises error about unknown state' do
        expect { subject.send(:get_async_import_result) }.to raise_error(ScormCloudClient::Exceptions::ScormCloudException) do |error|
          expect(error.message).to be_eql('Unknown state of async import')
          expect(error.code).to be_eql(ScormCloudClient::Client::CUSTOM_ERROR_CODE)
          expect(error.xml).to be_eql(subject.send(:xml).to_xml)
        end
      end
    end
  end
end
