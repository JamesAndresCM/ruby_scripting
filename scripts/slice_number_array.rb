class Array
  def slice_number_method(n)
    return self if self.size <= 1
    self.each_with_object([]).each do |el, arr|
      arr << self.slice!(0..(n-1))
      arr << self if self.size.eql? 1
    end
  end
end

 range = [1,23,45,1,23,4,5,12,3,12]
 p range.slice_number_method(3)
