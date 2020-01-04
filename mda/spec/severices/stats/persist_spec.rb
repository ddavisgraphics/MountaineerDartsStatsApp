require 'json'
require 'rails_helper'

RSpec.describe Stats::Persist do
  let(:json) { JSON.parse file_fixture("match.json").read }

  describe 'Data Setup' do
    it 'can read the file and expect it to be a hash' do
      expect(json).to be_a Hash
    end

    it 'expects home and away data' do
      expect(json['home']).to be_a Hash
      expect(json['away']).to be_a Hash
    end
  end

  describe '.init' do
    it 'sets the match instance variable in the class on init' do
      obj = Stats::Persist.new(json['home'], 1, 1)
      expect(obj.instance_variable_get(:@match)).to eql(json['home'].deep_symbolize_keys)
      expect(obj.instance_variable_get(:@week)).to eql(1)
      expect(obj.instance_variable_get(:@season_id)).to eql(1)
    end
  end

  describe '.singles' do
    it 'returns a array of objects' do
      obj = Stats::Persist.new(json['home'], 1, 1)
      expect(obj.singles).to be_a Array
      expect(obj.singles.count).to eq(4)
    end
  end

  describe '.team' do
    it 'cricket param returns a array of objects' do
      obj = Stats::Persist.new(json['home'], 1, 1)
      expect(obj.team(:cricket)).to be_a Array
      expect(obj.team(:cricket).count).to eq(4)
    end

    it 'choice returns a array of objects' do
      obj = Stats::Persist.new(json['home'], 1, 1)
      expect(obj.team(:choice)).to be_a Array
      expect(obj.team(:choice).count).to eq(4)
    end
  end
end
