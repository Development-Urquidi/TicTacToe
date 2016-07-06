require_relative 'spec'

RSpec.describe Engine do
  let(:engine) { Engine.new }
  subject { engine }

  before { allow_any_instance_of(Engine).to receive(:answer).and_return('yes') }

  describe 'attributes' do
    it { is_expected.to have_attr_accessor :board }
    it { is_expected.to have_attr_accessor :current_player }
  end

  describe 'public methods' do
    it { is_expected.to have_public_method :start }
    it { is_expected.to have_public_method :request_human_move }
  end

  describe 'private methods' do
    it { is_expected.to have_private_method :check_for_winner }
    it { is_expected.to have_private_method :replay }
  end

  describe '#start' do
    subject { -> { engine.start } }

    it { is_expected.to output(/Do\ you\ want\ to\ go\ first\?\ /).to_stdout }

    it { expect(ObjectSpace.each_object(Board).count).to eq 1 }

    it { expect(ObjectSpace.each_object(Player).count).to eq 2 }
    it { expect(ObjectSpace.each_object(Player).collect(&:type).uniq.sort).to eq %w{human robot} }
    it { expect(ObjectSpace.each_object(Player).collect(&:token).uniq.sort).to eq %w{X Y} }

    describe 'current_user' do
      subject { engine.current_player.type }

      context 'affirmative response' do
        it { engine.start and is_expected.to eq 'human' }
      end
      context 'negative response' do
        before { allow_any_instance_of(Engine).to receive(:answer).and_return('no') }
        it { engine.start and is_expected.to eq 'robot' }
      end
    end
  end

  it 'plays each turn' do
    expect(engine).to receive(:check_for_winner).exactly(9).times
  end
end