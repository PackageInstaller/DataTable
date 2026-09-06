local Node = class("Node")
local Edge = require("logic.dungeon.generator.delaunay-triangulation.edge")

function Node:Ctor(context)
  self._context = context
  self._edges = {}
end

function Node:same(rhs)
  if self._context ~= rhs._context then
    return false
  end
  if #self._edges ~= #rhs._edges then
    return false
  end
  for i = 1, #self._edges do
    if self._edges[i] ~= rhs._edges[i] then
      return false
    end
  end
  return true
end

function Node:AddEdge(to, weight)
  local edge = Edge.Create(self, to, weight)
  table.insert(self._edges, edge)
end

function Node:GetNeighbors()
  local tmp = {}
  for _, v in pairs(self._edges) do
    table.insert(tmp, v.p2)
  end
  return tmp
end

function Node:GetWeight(rhs)
  for _, edge in pairs(self._edges) do
    if edge.p2 == rhs then
      return edge.weight
    end
  end
  return math.huge - 1
end

return Node
