module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    length.times do |x|
      yield(self[x], x)
    end
  end

  def my_select
    length.times do |x|
      puts self[x] if yield(self[x])
    end
  end

  def my_all?
    length.times do |x|
      return false if yield(self[x]) != true
    end
    true
  end

  def my_any?
    length.times do |x|
      return true if yield(self[x])
    end
    false
  end

  def my_none?
    length.times do |x|
      return false if yield(self[x])
    end
    true
  end

  def my_count
    counter = 0
    length.times do |x|
      counter += 1 if yield(self[x])
    end
    counter
  end

  def my_map(proc = nil)
    new_arr = []
    if proc
      length.times do |x|
        new_arr[x] = proc.call(self[x])
      end
    else
      length.times do |x|
        new_arr[x] = yield(self[x])
      end
    end
    puts new_arr
  end

  def my_inject(arr = 0)
    acum = arr
    length.times do |x|
      acum = yield(acum, self[x])
    end
    acum
  end

  def multiply_els
    my_inject(1) do |k, x|
      k * x
    end
  end
end
