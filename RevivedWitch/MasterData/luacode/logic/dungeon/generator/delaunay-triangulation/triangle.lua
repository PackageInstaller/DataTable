-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/delaunay-triangulation/triangle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
require("logic.dungeon.generator.delaunay-triangulation.functions")
local Edge = require("logic.dungeon.generator.delaunay-triangulation.edge")
local Triangle = class("Triangle")
Triangle.Ctor = function(self, p1, p2, p3)
  -- function num : 0_0 , upvalues : _ENV, Edge
  assert(not isFlatAngle(p1, p2, p3), ("angle (p1, p2, p3) is flat:\n  %s\n  %s\n  %s\n%s"):format(tostring(p1), tostring(p2), tostring(p3), (debug.traceback)()))
  self.p1 = p1
  self.e1 = (Edge.Create)(p1, p2)
end

Triangle.isCW = function(self)
  -- function num : 0_1 , upvalues : _ENV
  do return crossProduct(self.p1, self.p2, self.p3) < 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Triangle.isCCW = function(self)
  -- function num : 0_2 , upvalues : _ENV
  do return crossProduct(self.p1, self.p2, self.p3) > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Triangle.getSidesLength = function(self)
  -- function num : 0_3
  return (self.e1):length(), (self.e2):length(), (self.e3):length()
end

Triangle.getCenter = function(self)
  -- function num : 0_4
  local x = ((self.p1).x + (self.p2).x + (self.p3).x) / 3
  local y = ((self.p1).y + (self.p2).y + (self.p3).y) / 3
  return x, y
end

Triangle.getCircumCircle = function(self)
  -- function num : 0_5
  local x, y = self:getCircumCenter()
  local r = self:getCircumRadius()
  return x, y, r
end

Triangle.getCircumCenter = function(self)
  -- function num : 0_6
  local p1, p2, p3 = self.p1, self.p2, self.p3
  local D = (p1.x * (p2.y - p3.y) + p2.x * (p3.y - p1.y) + p3.x * (p1.y - p2.y)) * 2
  local x = (p1.x * p1.x + p1.y * p1.y) * (p2.y - p3.y) + (p2.x * p2.x + p2.y * p2.y) * (p3.y - p1.y) + (p3.x * p3.x + p3.y * p3.y) * (p1.y - p2.y)
  local y = (p1.x * p1.x + p1.y * p1.y) * (p3.x - p2.x) + (p2.x * p2.x + p2.y * p2.y) * (p1.x - p3.x) + (p3.x * p3.x + p3.y * p3.y) * (p2.x - p1.x)
  return x / D, y / D
end

Triangle.getCircumRadius = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local a, b, c = self:getSidesLength()
  return a * b * c / quatCross(a, b, c)
end

Triangle.getArea = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local a, b, c = self:getSidesLength()
  return quatCross(a, b, c) / 4
end

Triangle.inCircumCircle = function(self, p)
  -- function num : 0_9
  return p:isInCircle(self:getCircumCircle())
end

return Triangle

