local Prim = class("Prim")
local Graph = require("logic.dungeon.generator.prim.graph")
local PQueue = require("framework.pqueue")
local infinity = math.huge - 1

local function delete_min(graph, d)
  local min_node
  local min_weight = infinity
  for _, n in pairs(graph:GetNodes()) do
    if min_weight >= d[n] then
      min_weight = d[n]
      min_node = n
    end
  end
  graph:Remove(min_node)
  return min_node
end

function Prim.prim(graph, start_node)
  local q = clone(graph)
  local d = {}
  for _, u in pairs(q:GetNodes()) do
    d[u] = infinity
  end
  d[start_node] = 0
  local result = {}
  while 0 < q:Size() do
    local u = delete_min(q, d)
    for _, v in pairs(u:GetNeighbors()) do
      if q:Contains(v) and u:GetWeight(v) < d[v] then
        d[v] = u:GetWeight(v)
        result[v] = u
      end
    end
  end
  return result
end

return Prim
