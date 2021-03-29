require_relative "../enumerable"

RSpec.describe Enumerable do
  let(:array) {%w[apple Orange Watermelon Banana]}
  let(:hash) {{fruit: 'banana', phone: 'apple'}}
  let(:number_array) {[1, 2, 3, 4]}
  let(:arr) {[]}
  let(:false_arr){[false]}
  let(:true_arr){[1,3,5]}

  describe '#my_each' do

    it 'returns the array' do
      expect(array.my_each {|fruit| fruit}).to eql(array)
    end

    it 'returns the array after the numbers are double' do
      expect(number_array.my_each {|number| number*2}).to eql(number_array.each {|number| number*2})
    end

    it 'my_each when self is a hash' do
      expect(hash.each { |key, value| "k: #{key}, v: #{value}" }).to eql({:fruit=>'banana', :phone=>'apple'})
    end

  end

  describe '#my_each_with_index' do

    it 'returns the doubled indexes for an array' do
      expect(number_array.my_each_with_index {|number, index| index*2}).to eql(number_array.each_with_index{|number, index| index*2})
    end

    it 'return all elements that are even index' do
     expect(number_array.my_each_with_index {|number, index| number if index % 2 == 0}).to eql(number_array.each_with_index{|number, index| number if index % 2 == 0})
    end
    
    it 'return hash if an index for key is 1' do
    expect(hash.my_each_with_index {|hash, index| hash if index ==  1}).to eql(hash.each_with_index {|hash, index| hash if index ==  1})
    end
    
  end

  describe '#my_select' do
    
    it 'return elements that have 6 letters' do
      expect(array.my_select {|word| word if word.length == 6}).to eq(['Orange', 'Banana'])
    end

    it 'returns all the numbers divisible by 2' do
      expect(number_array.my_select {|number| number if number.even?}).to eq([2, 4])
    end
  end

  describe '#my_all' do
     
    it 'returns true if we do not have a block' do
    expect(arr.my_all?).to be true
    end
    
    it 'returns a false if we do have a false element' do
       expect(false_arr.my_all?).to be false
    end
    
    it 'returns true if the all elements are odd numbers' do
      expect(true_arr.my_all? {|number| number if number.odd?}).to be true
    end

    it 'return true if the all elements in the array matches the class' do
      expect(number_array.my_all?(Numeric)).to eql(true)
    end

    it 'returns true if the all elements contains letter a' do 
      expect(array.my_all?(/a/)).to eql(true)
    end

    it 'returns a true if the elements in the array matches with parameter' do
      expect(['microverse'].my_all?('microverse')).to be true
    end

    it 'returns a false if the elements in the array does not matches with parameter' do
      expect(['microverse'].my_all?('microverseschool')).to be false
    end
  end

  describe 'my_any?' do
    
    it 'returns true if any elements are true with no block given' do
    expect([false, nil, true, 8].my_any?).to be true
    end

    it 'returns false if none of the elements are true' do
    expect(false_arr.my_any?).to be false
    end

    it 'returns true if any of the elements are even numbers' do
      expect(number_array.my_any? {|number| number.even?}).to be true
    end

    it 'returns true if any of the elements matches the class' do
      expect([1, 'word', false].my_any?(Numeric)).to be true
    end

    it 'return true if any of the elements contain the letter g' do
      expect(array.my_any?(/g/)).to eql(true)
    end

    it 'return true if any of the elements matches the parameter' do
      expect([true, 'microverse', array].my_any?('microverse')).to be true
    end

    it 'return false if nothing in the array matches with the block' do
      expect(number_array.my_any? {|number| number > 5}).to be false
    end
  end

  describe '#my_none?' do

    it 'returns true if we do not have a block on an empty array' do
        expect(arr.my_none?).to be true
    end

    it 'returns a false if we only have false elements' do
        expect(false_arr.my_none?).to be true
    end

    it 'returns true if no elements match the block' do
      expect(number_array.my_none? {|number| number > 5}).to be true
    end
    
    it 'returns true if no elements are from the given class' do
      expect(array.my_none?(Numeric)).to be true
    end

    it 'return true if none of the elements contain the letter z' do
      expect(array.my_none?(/z/)).to be true
    end

    it 'returns true if none of the elements matches the parameter' do
      expect(['microverse', 'freecodecamp', 'odin_projects'].my_none?('codecademy')).to be true
    end

    it 'returns false if any of the elements matches the block' do
      expect(number_array.my_none? {|number| number == 3}).to be false
    end
  end
end