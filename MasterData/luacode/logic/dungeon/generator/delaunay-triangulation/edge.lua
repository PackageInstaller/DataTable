require("logic.dungeon.generator.delaunay-triangulation.functions")
local Edge = class("Edge")

function Edge:Ctor(p1, p2, w)
  self.p1, self.p2, self.weight = p1, p2, w or 1
end

function Edge:same(otherEdge)
  return (not self.p1:same(otherEdge.p1) or not self.p2:same(otherEdge.p2)) and self.p1:same(otherEdge.p2) and self.p2:same(otherEdge.p1)
end

function Edge:length()
  return self.p1:dist(self.p2)
end

function Edge:getMidPoint()
  local x = self.p1.x + (self.p2.x - self.p1.x) / 2
  local y = self.p1.x + (self.p2.y - self.p1.y) / 2
  return x, y
end

return Edge
