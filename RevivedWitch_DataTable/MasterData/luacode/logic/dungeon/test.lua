-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/test.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SpatialAStar = require("logic.dungeon.pathfinding.spatialastar")
local Prim = require("logic.dungeon.generator.prim.prim")
local Graph = require("logic.dungeon.generator.prim.graph")
local range = {}
for i = 1, 8 do
  (table.insert)(range, i)
end
local graph = (Graph.Create)(range)
graph:SetEdge(0, 1, 8)
graph:SetEdge(0, 2, 9)
graph:SetEdge(0, 3, 11)
graph:SetEdge(1, 4, 10)
graph:SetEdge(2, 3, 13)
graph:SetEdge(2, 4, 5)
graph:SetEdge(2, 5, 12)
graph:SetEdge(3, 6, 8)
graph:SetEdge(5, 6, 7)
local prim = (Prim.Create)()
local result = (prim.prim)(graph, 1)
for k,v in pairs(result) do
  print(k._context, v._context)
end
local grids = {
{}
}
local astar = (SpatialAStar.Create)(10, 10)
local context = {iswalkable = function(ctx, pt)
  -- function num : 0_0 , upvalues : _ENV
  local l = {
{x = 0, y = 0}
, 
{x = 0, y = 1}
, 
{x = 1, y = 1}
, 
{x = 1, y = 2}
, 
{x = 1, y = 3}
, 
{x = 1, y = 4}
, 
{x = 1, y = 5}
, 
{x = 1, y = 6}
, 
{x = 1, y = 7}
, 
{x = 1, y = 8}
, 
{x = 2, y = 8}
, 
{x = 3, y = 8}
, 
{x = 4, y = 8}
, 
{x = 5, y = 8}
, 
{x = 6, y = 8}
, 
{x = 7, y = 8}
, 
{x = 8, y = 8}
}
  for k,v in pairs(l) do
    if v.x == pt.x and v.y == pt.y then
      return true
    end
  end
end
, CanWalkAcross = function()
  -- function num : 0_1
  return true
end
}
local succ = false
succ = astar:Search({x = 0, y = 0}, {x = 8, y = 8}, context)
print("\n\n", succ)
for _,v in pairs(result) do
  print(v.x, v.y)
end

