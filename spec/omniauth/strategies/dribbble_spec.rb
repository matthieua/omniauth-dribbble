require 'spec_helper'

describe OmniAuth::Strategies::Dribbble do
  let(:access_token) { double('AccessToken', :options => {}) }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', :parsed => parsed_response) }

  subject { OmniAuth::Strategies::Dribbble.new({}) }

  before do
    subject.stub(:access_token).and_return(access_token)
  end

  context 'client options' do
    it 'has the correct site' do
      expect(subject.options.client_options.site).to eq('https://api.dribbble.com')
    end

    it 'has the correct authorize URL' do
      expect(subject.options.client_options.authorize_url).to eq('https://dribbble.com/oauth/authorize')
    end

    it 'has the correct token URL' do
      expect(subject.options.client_options.token_url).to eq('https://dribbble.com/oauth/token')
    end
  end

  context '#raw_info' do
    it 'uses absolute paths' do
      access_token.should_receive(:get).with('/v2/user').and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end
  end
end
