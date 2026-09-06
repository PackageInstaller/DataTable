function quatCross(a, b, c)
  local p = (a + b + c) * (a + b - c) * (a - b + c) * (-a + b + c)
  
  return math.sqrt(p)
end

function crossProduct(p1, p2, p3)
  local x1, x2 = p2.x - p1.x, p3.x - p2.x
  local y1, y2 = p2.y - p1.y, p3.y - p2.y
  return x1 * y2 - y1 * x2
end

function isFlatAngle(p1, p2, p3)
  return crossProduct(p1, p2, p3) == 0
end
