require 'spec_helper'

describe Waiter do
  def side_effect_call!
    @num_calls += 1
  end

  before(:each) do
    @num_calls = 0
  end

  context "delegate all" do
    it "does not calculate anything when just called" do
      expect(@num_calls).to eq(0)
      result = Waiter.serve { side_effect_call!; 2 }
      expect(@num_calls).to eq(0)
    end

    it "returns correct result" do
      result = Waiter.serve { side_effect_call!; 2 }
      expect(result + 1).to eq(3)
    end

    it "calculates only once" do
      result = Waiter.serve { side_effect_call!; 2 }
      result.to_i
      expect(@num_calls).to eq(1)
      result.to_i
      expect(@num_calls).to eq(1)
    end
  end

  context "delegate partially" do
    it "only delegates specific methods" do
      result = Waiter.serve(:+) { side_effect_call!; 2 }
      expect(result + 1).to eq(3)
      expect { result - 1 }.to raise_error(NameError)
    end

    it "defines methods on singleton class" do
      result1 = Waiter.serve(:+) { side_effect_call!; 2 }
      result2 = Waiter.serve(:-) { side_effect_call!; 2 }
      expect { result + 1 }.to raise_error(NameError)
    end
  end
end
