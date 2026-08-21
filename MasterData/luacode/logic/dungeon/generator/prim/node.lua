-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/prim/node.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Node = class("Node")
local Edge = require("logic.dungeon.generator.delaunay-triangulation.edge")
Node.Ctor = function(self, context)
  -- function num : 0_0
  self._context = context
  self._edges = {}
end

Node.same = function(self, rhs)
  -- function num : 0_1
  if self._context ~= rhs._context then
    return false
  end
  if #self._edges ~= #rhs._edges then
    return false
  end
  for i = 1, #self._edges do
    if (self._edges)[i] ~= (rhs._edges)[i] then
      return false
    end
  end
  return true
end

Node.AddEdge = function(self, to, weight)
  -- function num : 0_2 , upvalues : Edge, _ENV
  local edge = (Edge.Create)(self, to, weight)
  ;
  (table.insert)(self._edges, edge)
end

Node.GetNeighbors = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local tmp = {}
  for _,v in pairs(self._edges) do
    (table.insert)(tmp, v.p2)
  end
  return tmp
end

Node.GetWeight = function(self, rhs)
  -- function num : 0_4 , upvalues : _ENV
  for _,edge in pairs(self._edges) do
    if edge.p2 == rhs then
      return edge.weight
    end
  end
  return math.huge - 1
end

return Node

