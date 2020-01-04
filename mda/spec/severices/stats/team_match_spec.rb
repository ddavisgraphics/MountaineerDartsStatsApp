require 'json'
require 'rails_helper'

RSpec.describe Stats::TeamMatch do
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
      obj = Stats::TeamMatch.new(json['home']['cricket']['1'])
      expect(obj.instance_variable_get(:@match)).to eql(json['home']['cricket']['1'].deep_symbolize_keys)
    end
  end

  describe '.match_data' do
    context "Works with Cricket and Choice" do
      it 'returns Array for Cricket' do
        obj = Stats::TeamMatch.new(json['home']['cricket']['1'])
        expect(obj.match_data).to be_a Array
        expect(obj.match_data[0].keys).to eq([:legs_won, :legs_lost, :match_won, :player_id])
      end

      it 'returns Array for Choice' do
        obj = Stats::TeamMatch.new(json['home']['choice']['1'])
        expect(obj.match_data).to be_a Array
        expect(obj.match_data[0].keys).to eq([:legs_won, :legs_lost, :match_won, :player_id])
      end
    end 
  end

 
end
