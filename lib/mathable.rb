module Mathable
  def percent(counted, total)
    ((counted.to_f / total) * 100).round(2)
  end

  def ratio(counted, total)
    (counted.to_f / total).round(2)
  end
end
