-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/prim/graph.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Graph = class("Graph")
local Node = require("logic.dungeon.generator.prim.node")
Graph.Ctor = function(self, initializer_list)
  -- function num : 0_0 , upvalues : _ENV
  self._nodes = {}
  for _,v in ipairs(initializer_list) do
    self:AddVertex(v)
  end
end

Graph.Size = function(self)
  -- function num : 0_1
  return #self._nodes
end

Graph.GetNodes = function(self)
  -- function num : 0_2
  return self._nodes
end

Graph.AddVertex = function(self, context)
  -- function num : 0_3 , upvalues : Node, _ENV
  local node = (Node.Create)(context)
  ;
  (table.insert)(self._nodes, node)
  return node
end

Graph.FindVertex = function(self, context)
  -- function num : 0_4 , upvalues : _ENV
  for _,node in pairs(self._nodes) do
    if node._context == context then
      return node
    end
  end
end

Graph.Contains = function(self, n)
  -- function num : 0_5 , upvalues : _ENV
  for _,node in pairs(self._nodes) do
    if node == n then
      return true
    end
  end
  return false
end

Graph.Remove = function(self, n)
  -- function num : 0_6 , upvalues : _ENV
  for k,node in pairs(self._nodes) do
    if node == n then
      (table.remove)(self._nodes, k)
      return 
    end
  end
end

Graph.SetEdge = function(self, from_context, to_context, weight)
  -- function num : 0_7
  if not self:FindVertex(from_context) then
    local from = self:AddVertex(from_context)
  end
  if not self:FindVertex(to_context) then
    local to = self:AddVertex(to_context)
  end
  from:AddEdge(to, weight)
  to:AddEdge(from, weight)
end

Graph.CopyFrom = function(self, rhs)
  -- function num : 0_8 , upvalues : _ENV
  self._nodes = clone(rhs._nodes)
end

return Graph

