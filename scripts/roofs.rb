roofs = [4, 2, 1, 6, 3, 2, 5, 3, 1, 4]
aux = []
roofs.each_with_index do |roof, original_index|
  roofs.each.with_index(original_index + 1) do |el, index|
    if roofs[index]
      if roof < roofs[index]
        aux << roofs[index]
       break
      end
    else
      aux << -1
      break
    end
  end
end
p aux
