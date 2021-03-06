require 'spec_helper'

describe ScormCloudClient::Services::Course do
  subject { FactoryGirl.build(:course_service) }

  context 'API methods' do
    before { allow(subject).to receive(:execute_method) }
    let(:params) { { key: :value } }

    describe '#import_course' do
      it 'executes method "importCourse" with params and file' do
        expect(subject).to receive(:execute_method).with('importCourse', params, file: :file)
        subject.import_course(:file, params)
      end
    end

    describe '#exists' do
      it 'executes method "exists" with params' do
        expect(subject).to receive(:execute_method).with('exists', params)
        subject.exists(params)
      end
    end

    describe '#get_course_list' do
      it 'executes method "getCourseList"' do
        expect(subject).to receive(:execute_method).with('getCourseList')
        subject.get_course_list
      end
    end

    describe '#import_course_async' do
      it 'executes method "importCourseAsync" with params' do
        expect(subject).to receive(:execute_method).with('importCourseAsync', params, file: :file)
        subject.import_course_async(:file, params)
      end
    end

    describe '#get_async_import_result' do
      let(:token) { 'token_id' }

      it 'executes method "getAsyncImportResult" with params' do
        expect(subject).to receive(:execute_method).with('getAsyncImportResult', token: token)
        subject.get_async_import_result(token)
      end
    end
  end

  it_behaves_like 'service', prefix: described_class::API_METHOD_PREFIX, methods: { importCourse: :post, updateAssets: :post, importCourseAsync: :post }
end
