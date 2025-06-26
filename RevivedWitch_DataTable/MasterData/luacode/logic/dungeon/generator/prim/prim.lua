-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/prim/prim.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Prim = class("Prim")
local Graph = require("logic.dungeon.generator.prim.graph")
local PQueue = require("framework.pqueue")
local infinity = math.huge - 1
local delete_min = function(graph, d)
  -- function num : 0_0 , upvalues : infinity, _ENV
  local min_node = nil
  local min_weight = infinity
  for _,n in pairs(graph:GetNodes()) do
    if d[n] <= min_weight then
      min_weight = d[n]
      min_node = n
    end
  end
  graph:Remove(min_node)
  return min_node
end

Prim.prim = function(graph, start_node)
  -- function num : 0_1 , upvalues : _ENV, infinity, delete_min
  local q = clone(graph)
  local d = {}
  for _,u in pairs(q:GetNodes()) do
    d[u] = infinity
  end
  d[start_node] = 0
  local result = {}
  while q:Size() > 0 do
    local u = delete_min(q, d)
    for _,v in pairs(u:GetNeighbors()) do
      if q:Contains(v) and u:GetWeight(v) < d[v] then
        d[v] = u:GetWeight(v)
        result[v] = u
      end
    end
  end
  do
    return result
  end
end

return Prim

