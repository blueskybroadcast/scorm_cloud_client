require 'spec_helper'

describe ScormCloudClient::Responses::Registration do
  let(:response) { FactoryGirl.build(:registration_response, specified_path: fixture) }

  describe '#registration_result' do
    subject { response.registration_result }

    context 'when format is "course"' do
      let(:fixture) { 'registration/results/course.xml' }
      let(:result) do
        {
          registration_id: 'myreg42',
          total_time: 324,
          score: 17,
          complete: true,
          success: true
        }
      end

      it { is_expected.to eq result }
    end

    context 'when format is "activity"' do
      let(:fixture) { 'registration/results/activity.xml' }
      let(:result) do
        {
          registration_id: 'myreg27',
          total_time: 942,
          score: 43,
          complete: false,
          success: true
        }
      end

      it { is_expected.to eq result }
    end

    context 'when format is "full"' do
      let(:fixture) { 'registration/results/full.xml' }
      let(:result) do
        {
          registration_id: 'myreg74',
          total_time: 244928,
          score: 53,
          complete: false,
          success: false
        }
      end

      it { is_expected.to eq result }
    end

    context 'when format is different' do
      let(:fixture) { 'registration/results/whatever.xml' }

      it { expect { subject }.to raise_error(
        ScormCloudClient::Exceptions::UnsupportedFormatException,
        'Unsupported format: whatever'
      ) }
    end
  end
end
