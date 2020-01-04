require 'json'
require 'rails_helper'

RSpec.describe Stats::Player501 do
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
      obj = Stats::Player501.new(json['home']['501'])
      expect(obj.instance_variable_get(:@match)).to eql(json['home']['501'].deep_symbolize_keys)
    end
  end

  describe '.leg_data' do
    before(:each) do
      @stat = Stats::Player501.new(json['home']['501']['player_1'])
    end

    it 'should get back hash' do
      expect(@stat.leg_data).to be_a Hash
    end

    it 'should have the following keys' do
      expect(@stat.leg_data).to have_key(:legs_won)
      expect(@stat.leg_data).to have_key(:legs_lost)
      expect(@stat.leg_data).to have_key(:match_won)
      expect(@stat.leg_data).to have_key(:darts)
      expect(@stat.leg_data).to have_key(:points)
    end

    context 'real values' do
      it 'should have a darts value' do
        data = @stat.leg_data
        expect(data[:darts]).to be_within(0.1).of(72.0)
      end
      it 'should have a points value' do
        data = @stat.leg_data
        expect(data[:points]).to be_within(0.1).of(1333.0)
      end
      it 'should have match lost value' do
        data = @stat.leg_data
        expect(data[:match_won]).to be false
      end 
      it 'should have legs won value' do
        data = @stat.leg_data 
        expect(data[:legs_won]).to eq(0)
      end 
      it 'should have legs won value' do
        data = @stat.leg_data
        expect(data[:legs_lost]).to eq(3)
      end
    end
  end

  describe '.generate_averages' do
    before(:each) do
      @stat = Stats::Player501.new(json['home']['501']['player_1'])
    end
    
    it 'points per dart' do
      data = @stat.generate_averages
      expect(data[:ppd]).to be_within(0.1).of(18.5)
    end

    it '3 dart average' do
      data = @stat.generate_averages
      expect(data[:average]).to be_within(0.1).of(55.5)
    end

  end 

  describe '.match_stats' do
    before(:each) do
      @stat = Stats::Player501.new(json['home']['501']['player_1'])
    end

    it 'returns a hash' do
      expect(@stat.match_stats).to be_a Hash
    end

    it 'returns a hash' do
      stats = {:legs_won=>0, :legs_lost=>3, :match_won=>false, :darts=>72.0, :points=>1333.0, :player_id=>"1", :average=>55.542, :ppd=>18.514}
      expect(@stat.match_stats).to eq stats
    end
  end
end
