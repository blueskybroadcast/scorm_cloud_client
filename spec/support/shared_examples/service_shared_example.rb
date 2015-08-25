shared_examples 'service' do |options|
  describe '#full_method' do
    let(:method_name) { 'method_name' }
    let(:result) { "#{options[:prefix]}.#{method_name}" }

    it 'returns full method name for service' do
      expect(subject.send(:full_method, method_name)).to be_eql result
    end
  end

  describe '#specified_http_mehods' do
    it 'returns list of specified http methods' do
      expect(subject.send(:specified_http_mehods)).to be_eql options[:methods]
    end
  end
end
