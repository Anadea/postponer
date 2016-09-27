require 'spec_helper'

describe Postponer do
  def side_effect_call!
    @num_calls += 1
  end

  before(:each) do
    @num_calls = 0
  end

  describe ".defer" do
    context "delegate all" do
      it "does not calculate anything when just called" do
        expect(@num_calls).to eq(0)
        result = described_class.defer { side_effect_call!; 2 }
        expect(@num_calls).to eq(0)
      end

      it "returns correct result" do
        result = described_class.defer { side_effect_call!; 2 }
        expect(result + 1).to eq(3)
      end

      it "calculates only once" do
        result = described_class.defer { side_effect_call!; 2 }
        result.to_i
        expect(@num_calls).to eq(1)
        result.to_i
        expect(@num_calls).to eq(1)
      end
    end

    context "delegate partially" do
      it "only delegates specific methods" do
        result = described_class.defer(:+) { side_effect_call!; 2 }
        expect(result + 1).to eq(3)
        expect { result - 1 }.to raise_error(NameError)
      end

      it "defines methods on singleton class" do
        result1 = described_class.defer(:+) { side_effect_call!; 2 }
        result2 = described_class.defer(:-) { side_effect_call!; 2 }
        expect { result + 1 }.to raise_error(NameError)
      end
    end
  end
end
