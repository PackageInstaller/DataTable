-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/delaunay-triangulation/edge.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
require("logic.dungeon.generator.delaunay-triangulation.functions")
local Edge = class("Edge")
Edge.Ctor = function(self, p1, p2, w)
  -- function num : 0_0
  self.p1 = p1
end

Edge.same = function(self, otherEdge)
  -- function num : 0_1
  if (not (self.p1):same(otherEdge.p1) or not (self.p2):same(otherEdge.p2)) and (self.p1):same(otherEdge.p2) then
    return (self.p2):same(otherEdge.p1)
  end
end

Edge.length = function(self)
  -- function num : 0_2
  return (self.p1):dist(self.p2)
end

Edge.getMidPoint = function(self)
  -- function num : 0_3
  local x = (self.p1).x + ((self.p2).x - (self.p1).x) / 2
  local y = (self.p1).x + ((self.p2).y - (self.p1).y) / 2
  return x, y
end

return Edge

