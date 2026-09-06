require("logic.dungeon.generator.delaunay-triangulation.functions")
local Edge = require("logic.dungeon.generator.delaunay-triangulation.edge")
local Triangle = class("Triangle")

function Triangle:Ctor(p1, p2, p3)
  assert(not isFlatAngle(p1, p2, p3), ([[
angle (p1, p2, p3) is flat:
  %s
  %s
  %s
%s]]):format(tostring(p1), tostring(p2), tostring(p3), debug.traceback()))
  self.p1, self.p2, self.p3 = p1, p2, p3
  self.e1, self.e2, self.e3 = Edge.Create(p1, p2), Edge.Create(p2, p3), Edge.Create(p3, p1)
end

function Triangle:isCW()
  return crossProduct(self.p1, self.p2, self.p3) < 0
end

function Triangle:isCCW()
  return crossProduct(self.p1, self.p2, self.p3) > 0
end

function Triangle:getSidesLength()
  return self.e1:length(), self.e2:length(), self.e3:length()
end

function Triangle:getCenter()
  local x = (self.p1.x + self.p2.x + self.p3.x) / 3
  local y = (self.p1.y + self.p2.y + self.p3.y) / 3
  return x, y
end

function Triangle:getCircumCircle()
  local x, y = self:getCircumCenter()
  local r = self:getCircumRadius()
  return x, y, r
end

function Triangle:getCircumCenter()
  local p1, p2, p3 = self.p1, self.p2, self.p3
  local D = (p1.x * (p2.y - p3.y) + p2.x * (p3.y - p1.y) + p3.x * (p1.y - p2.y)) * 2
  local x = (p1.x * p1.x + p1.y * p1.y) * (p2.y - p3.y) + (p2.x * p2.x + p2.y * p2.y) * (p3.y - p1.y) + (p3.x * p3.x + p3.y * p3.y) * (p1.y - p2.y)
  local y = (p1.x * p1.x + p1.y * p1.y) * (p3.x - p2.x) + (p2.x * p2.x + p2.y * p2.y) * (p1.x - p3.x) + (p3.x * p3.x + p3.y * p3.y) * (p2.x - p1.x)
  return x / D, y / D
end

function Triangle:getCircumRadius()
  local a, b, c = self:getSidesLength()
  return a * b * c / quatCross(a, b, c)
end

function Triangle:getArea()
  local a, b, c = self:getSidesLength()
  return quatCross(a, b, c) / 4
end

function Triangle:inCircumCircle(p)
  return p:isInCircle(self:getCircumCircle())
end

return Triangle
