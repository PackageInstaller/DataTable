-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/delaunay-triangulation/functions.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
quatCross = function(a, b, c)
  -- function num : 0_0 , upvalues : _ENV
  local p = (a + b + c) * (a + b - c) * (a - b + c) * (-a + b + c)
  return (math.sqrt)(p)
end

crossProduct = function(p1, p2, p3)
  -- function num : 0_1
  local x1, x2 = p2.x - p1.x, p3.x - p2.x
  local y1, y2 = p2.y - p1.y, p3.y - p2.y
  return x1 * y2 - y1 * x2
end

isFlatAngle = function(p1, p2, p3)
  -- function num : 0_2 , upvalues : _ENV
  do return crossProduct(p1, p2, p3) == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end


