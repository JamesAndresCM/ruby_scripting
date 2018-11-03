class Array
  def slice_number_method(n)
    return self if self.size <= 1 
    not_in_arr = []
    temp_arr = self.map do |ta| 
      (1..ta).to_a.pop(ta - (ta-n)) if ta % n == 0
    end.compact
  
    self.each do |last_num|
      temp_arr << last_num if last_num > temp_arr.flatten.last
    end

    temp_arr.each{|x|  not_in_arr << x unless x.is_a? self.class }
    temp_arr.push(not_in_arr) unless not_in_arr.empty?
    temp_arr.delete_if{|del| !del.is_a? self.class }
  end
end

 range = (1..13).to_a
 p range.slice_number_method(3)
