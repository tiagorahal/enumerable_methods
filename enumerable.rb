module Enumerable
  def my_each
    return enum_for(:my_each) unless block.given?

    i = 0
    while i < arr.size
      yield (self[i])
      i += 1
    end
  end
end

# my_each
[2, 5, 6, 7].my_each
[2, 5, 6, 7].my_each { puts 'enumerable' }
