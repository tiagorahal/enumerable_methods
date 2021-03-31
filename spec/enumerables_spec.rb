require_relative '../enumerable'

describe Enumerable do
  let(:array) { [1, 2, 3, 4] }
  let(:range) { (1..10) }
  let(:hash) { {} }

  describe '#my_each' do
    it 'returns an enumerator if no block is given' do
      expect(array.my_each.is_a?(Enumerable)).to eql(array.to_enum.is_a?(Enumerable))
    end

    it 'returns an array if the block is given' do
      expect(array.my_each { |num| num }).to eql([1, 2, 3, 4])
    end

    it 'returns an array if the block is given' do
      expect(array.my_each { |num| num }).to_not eql([])
    end

    it 'returns a range if the block is given' do
      expect(range.my_each { |num| num }).to eql((1..10))
    end
  end

  describe '#my_each_with_index' do
    it 'returns an enumerator if no block is given' do
      expect(array.my_each_with_index.is_a?(Enumerable)).to eql(array.to_enum.is_a?(Enumerable))
    end

    it 'returns a hash with the index as the value of the key' do
      %w[cat dog wombat].each_with_index { |item, index| hash[item] = index }
      expect(hash).to eql({ 'cat' => 0, 'dog' => 1, 'wombat' => 2 })
    end

    it 'returns a range if the block is given' do
      expect(range.my_each_with_index { |num| num }).to eql((1..10))
    end

    it 'returns a range if the block is given' do
      expect(range.my_each_with_index { |num| num }).to_not eql([])
    end
  end

  describe '#my_select' do
    it 'returns a range if the block is given' do
      expect(range.my_select { |i| i % 3 == 0 }).to eql([3, 6, 9])
    end

    it 'returns a even number if the block is given' do
      expect(range.my_select(&:even?)).to eql([2, 4, 6, 8, 10])
    end

    it 'returns a even number if the block is given' do
      expect(range.my_select(&:even?)).to_not eql([])
    end
  end

  describe '#my_count' do
    it 'returns a count number if a block and arguments is not given' do
      expect(array.my_count)
    end

    it 'returns a count if an arguments is given' do
      expect(array.my_count(2))
    end

    it 'returns a count number if a block and arguments is given' do
      expect(array.my_count(&:even?)).to eql(2)
    end

    it 'returns a count number if a block and arguments is given' do
      expect(array.my_count(&:even?)).to_not eql(0)
    end
  end

  describe '#my_map' do
    it 'returns a count number if a block given' do
      expect(array.my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end

    it 'no block is given, an enumerator is returned instead' do
      expect(array.my_map { 'cat' }).to eql(%w[cat cat cat cat])
    end
  end

  describe '#my_all?' do
    it 'returns true if no block is given and none of the items are false or nil' do
      expect([].my_all?).to eql(true)
    end

    it 'returns false if no block is given and at least one of the items are false or nil' do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it 'returns true if every element in the array returns true for the condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'returns false if at least one of the elements returns false for the condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it 'returns whether pattern === element for every collection member' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it 'returns whether pattern === element for every collection member' do
      expect(%w[ant bear cat].my_all?(/a/)).to_not eql(false)
    end

    it 'returns true if every element is a member of a given class' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'returns false if no block is given and none of the items are true' do
      expect([].my_any?).to eql(false)
    end

    it 'returns true if no block is given and at least one of the items are true' do
      expect([nil, true, 99].my_any?).to eql(true)
    end

    it 'returns true if at least one element in the array returns true for the condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(true)
    end

    it 'returns true if at least one of the elements returns true for the condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eql(true)
    end

    it 'returns whether pattern === element for any collection member' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(false)
    end

    it 'returns whether pattern === element for any collection member' do
      expect(%w[ant bear cat].my_any?(/r/)).to_not eql(false)
    end
  end

  describe '#my_none?' do
    it 'returns true if no block is given and none of the items are true' do
      expect([nil, false].my_none?).to eql(true)
    end

    it 'returns false if no block is given and at least one of the items are true' do
      expect([nil, false, true].my_none?).to eql(false)
    end

    it 'returns true if none of the elements in the array returns true for the condition' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eql(true)
    end

    it 'returns false if at least one of the elements returns true for the condition' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to eql(false)
    end

    it 'returns whether pattern === element for none collection member' do
      expect(%w[ant bear cat].my_none?(/d/)).to eql(true)
    end

    it 'returns whether pattern === element for none collection member' do
      expect(%w[ant bear cat].my_none?(/r/)).to_not eql(true)
    end
  end

  describe '#my_inject?' do
    it 'returns the sum of the items when the input is a range and no initial value is given' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eql(45)
    end

    it 'returns the sum of the items and the initial when a symbol and initial value is given instead of a block' do
      expect((5..10).my_inject(10) { |sum, n| sum + n }).to_not eql(45)
    end

    it 'returns the sum of the items and the initial value when the input is a range and initial value is given' do
      expect((5..10).my_inject(10) { |sum, n| sum + n }).to eql(55)
    end

    it 'returns the sum of the items when a symbol is given instead of a block' do
      expect((5..10).my_inject(:+)).to eql(45)
    end

    it 'returns the sum of the items and the initial when a symbol and initial value is given instead of a block' do
      expect((5..10).my_inject(6, :+)).to eql(51)
    end

    it 'returns the longest word in the array, stored in the accumulator variable' do
      expect(%w[cat sheep bear].my_inject { |memo, word| memo.length > word.length ? memo : word }).to eql('sheep')
    end
  end

  describe '#multiply_els' do
    it 'returns the multiplication of each item in an array' do
      expect(multiply_els([2, 4, 5])).to eql(40)
    end

    it 'returns the multiplication of each item in a range' do
      expect(multiply_els(5..10)).to eql(151_200)
    end

    it 'returns the multiplication of each item in a range' do
      expect(multiply_els(5..10)).to_not eql(0)
    end
  end
end
