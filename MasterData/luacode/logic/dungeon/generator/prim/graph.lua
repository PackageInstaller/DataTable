local Graph = class("Graph")
local Node = require("logic.dungeon.generator.prim.node")

function Graph:Ctor(initializer_list)
  self._nodes = {}
  for _, v in ipairs(initializer_list) do
    self:AddVertex(v)
  end
end

function Graph:Size()
  return #self._nodes
end

function Graph:GetNodes()
  return self._nodes
end

function Graph:AddVertex(context)
  local node = Node.Create(context)
  table.insert(self._nodes, node)
  return node
end

function Graph:FindVertex(context)
  for _, node in pairs(self._nodes) do
    if node._context == context then
      return node
    end
  end
end

function Graph:Contains(n)
  for _, node in pairs(self._nodes) do
    if node == n then
      return true
    end
  end
  return false
end

function Graph:Remove(n)
  for k, node in pairs(self._nodes) do
    if node == n then
      table.remove(self._nodes, k)
      return
    end
  end
end

function Graph:SetEdge(from_context, to_context, weight)
  local from = self:FindVertex(from_context) or self:AddVertex(from_context)
  local to = self:FindVertex(to_context) or self:AddVertex(to_context)
  from:AddEdge(to, weight)
  to:AddEdge(from, weight)
end

function Graph:CopyFrom(rhs)
  self._nodes = clone(rhs._nodes)
end

return Graph
