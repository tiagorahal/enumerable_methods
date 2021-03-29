require_relative "../enumerable"

RSpec.describe Enumerable do
  let(:array) {%w[Apple Orange Watermelon Banana]}
  let(:hash) {{fruit: 'banana', phone: 'apple'}}
  let(:number_array) {[1, 2, 3, 4]}

  describe 'my_each' do

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

end