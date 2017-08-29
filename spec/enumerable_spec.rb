# spec/enumerable_spec.rb
require "enumerable"

describe "Enumerable" do

  let(:ary)   { [3, 5, 11] }
  let(:ary2)  { ["strings", "array", "cool"] }
  let(:ary3)  { ["mixed", 3, "array", 1.3, "yes"] }
  let(:new_ary) { [] }

  context "#my_each" do
    it "traverse each element" do
      expect { |block| ary.my_each(&block) }.to yield_successive_args(3, 5, 11)
    end

    it "correctly applies block to each element" do
			ary.my_each { |el| new_ary.push el * 2 }
      expect(new_ary).to eq([6, 10, 22])
		end
  end

  context "#my_each_with_index" do
    it "yields elements and indexes" do
      expect { |block| ary.my_each_with_index(&block) }.to yield_successive_args([3,0],[5,1],[11,2])
    end
  end

  context "#my_select" do
    it "return the elements specified by the block" do
      new_ary = ary.my_select { |el| el < 8 }
      expect(new_ary).to eql([3, 5])
    end
  end

  context "#my_all?" do
    it "return true if the elements are integer" do
      expect(ary.my_all? { |el| el.is_a? Integer }).to be_truthy
    end

    it "return false if the elements passed aren't integer" do
      expect(ary2.my_all? { |el| el.is_a? Integer }).to be_falsey
    end
  end

  context "#my_any?" do
    it "return true if any elements is an integer" do
      expect(ary.my_any? { |el| el.is_a? Integer }).to be_truthy
    end

    it "return true if any elements is a string" do
      expect(ary2.my_any? { |el| el.is_a? String }).to be_truthy
    end

    it "return true if any element is an integer from mixed array" do
      expect(ary3.my_any? { |el| el.is_a? Integer }).to be_truthy
    end

    it "return false if no elements are integer" do
      expect(ary2.my_any? { |el| el.is_a? Integer }).to be_falsey
    end
  end

  context "#my_none?" do
    it "return true if no elements are integer" do
      expect(ary2.my_none? { |el| el.is_a? Integer }).to be_truthy
    end

    it "return false if any element is an integer" do
      expect(ary3.my_none? { |el| el.is_a? Integer }).to be_falsey
    end
  end

  context "#my_count" do
    it "return 3 if the elements are strings" do
      expect(ary2.my_count { |el| el.is_a? String }).to eql(3)
    end

    it "return 3 if all elements are odds number" do
      expect(ary.my_count { |el| el % 2 == 0 }).to eql(0)
    end

    it "return 1 if one element is a float" do
      expect(ary3.my_count { |el| el.is_a? Float }).to eql(1)
    end
  end

  context "#my_map" do
    it "changes every element (if all integers)" do
      expect(ary.my_map { |el| el * 3 }).to eql([9,15,33])
    end

    it "changes every element (if all strings)" do
      expect(ary2.my_map { |el| el << "yes" }).to eql(["stringsyes", "arrayyes", "coolyes"])
    end
  end

  context "#my_inject" do
    it "sums all the integers from array" do
      expect(ary.my_inject { |sum, el| sum += el }).to eql(19)
    end

    it "start from initial value if specified" do
      expect(ary.my_inject(5) { |sum, el| sum += el }).to eql(24)
    end
  end

  context "multiply_els" do
    it "multiplies all integers in array" do
      expect(ary.multiply_els).to eql(165)
    end
  end

end
