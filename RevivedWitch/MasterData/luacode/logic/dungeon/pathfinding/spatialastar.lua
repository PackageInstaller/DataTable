-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/pathfinding/spatialastar.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SpatialAStar = class("SpatialAStar")
local Point = require("logic.dungeon.generator.delaunay-triangulation.point")
local PQueue = require("framework.pqueue")
SpatialAStar.Ctor = function(self, width, height)
  -- function num : 0_0 , upvalues : PQueue
  self._width = width
  self._height = height
  self._searchSpace = {}
  self._closeset = {}
  self._openset = {}
  self._cameFrom = {}
  self._runtimeGrid = {}
  self._orderedOpenSet = ((PQueue.Create)()):Init(function(lhs, rhs)
    -- function num : 0_0_0
    do return lhs.F < rhs.F end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

local add = function(tbl, x, y, value)
  -- function num : 0_1
  if not tbl[y] then
    tbl[y] = {}
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (tbl[y])[x] = value
  end
end

local remove = function(tbl, x, y)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  if tbl[y] then
    (tbl[y])[x] = nil
  end
end

local get_or_create = function(tbl, x, y)
  -- function num : 0_3
  if not tbl[y] then
    tbl[y] = {}
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

    if not (tbl[y])[x] then
      (tbl[y])[x] = {x = x, y = y, F = 0, G = 0, H = 0}
      return (tbl[y])[x]
    end
  end
end

local get = function(tbl, x, y)
  -- function num : 0_4
  if tbl[y] then
    return (tbl[y])[x]
  end
  return nil
end

local contains = function(tbl, x, y)
  -- function num : 0_5
  if (tbl[y])[x] == nil then
    do return not tbl[y] end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

local empty = function(tbl)
  -- function num : 0_6 , upvalues : _ENV
  for k,v in pairs(tbl) do
    for _,vv in pairs(v) do
      do return false end
    end
  end
  return true
end

SpatialAStar.Heuristic = function(self, start, stop)
  -- function num : 0_7
  return self:NeighborDistance(start, stop)
end

SpatialAStar.NeighborDistance = function(self, start, stop)
  -- function num : 0_8 , upvalues : _ENV
  return (math.abs)(start.x - stop.x) + (math.abs)(start.y - stop.y)
end

SpatialAStar.Search = function(self, start, stop, context)
  -- function num : 0_9 , upvalues : get_or_create, PQueue, add, empty, _ENV, remove, contains
  if start.x == stop.x and start.y == stop.y then
    return {start}, true
  end
  local start_node = get_or_create(self._searchSpace, start.x, start.y)
  local stop_node = get_or_create(self._searchSpace, stop.x, stop.y)
  local neighbors = {}
  local result = {}
  self._closeset = {}
  self._openset = {}
  self._cameFrom = {}
  self._runtimeGrid = {}
  local pqueue_ids = {}
  self._orderedOpenSet = ((PQueue.Create)()):Init(function(lhs, rhs)
    -- function num : 0_9_0
    do return lhs.F < rhs.F end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  start_node.G = 0
  start_node.H = self:Heuristic(start_node, stop_node)
  start_node.F = start_node.H
  add(self._openset, start_node.x, start_node.y, start_node)
  ;
  (self._orderedOpenSet):Push(start_node)
  add(self._runtimeGrid, start_node.x, start_node.y, start_node)
  local closest = nil
  while not empty(self._openset) do
    local x = (self._orderedOpenSet):Pop()
    if x.x == stop_node.x and x.y == stop_node.y then
      result = self:ReconstructPath(self._cameFrom, get_or_create(self._cameFrom, stop_node.x, stop_node.y))
      ;
      (table.insert)(result, stop)
      return result, true
    end
    remove(self._openset, x.x, x.y)
    add(self._closeset, x.x, x.y, x)
    neighbors = self:StoreNeighbors(x, context)
    for _,y in pairs(neighbors) do
      local tentativeIsBetter = false
      if context:iswalkable(y) and not contains(self._closeset, y.x, y.y) then
        local tentativeGScore = (get_or_create(self._runtimeGrid, x.x, x.y)).G + self:NeighborDistance(x, y)
        local wasAdded = false
        if not contains(self._openset, y.x, y.y) then
          add(self._openset, y.x, y.y, y)
          tentativeIsBetter = true
          wasAdded = true
        else
          tentativeIsBetter = tentativeGScore < (get_or_create(self._runtimeGrid, y.x, y.y)).G
        end
        if tentativeIsBetter then
          add(self._cameFrom, y.x, y.y, x)
          add(self._runtimeGrid, y.x, y.y, y)
          local node = get_or_create(self._runtimeGrid, y.x, y.y)
          node.G = tentativeGScore
          node.H = self:Heuristic(y, stop)
          node.F = node.G + node.H
          if not closest or node.F <= closest.F then
            closest = node
          end
          if wasAdded then
            local id = (self._orderedOpenSet):Push(y)
            add(pqueue_ids, y.x, y, y, id)
          else
            local id = get_or_create(pqueue_ids, y.x, y.y)
            ;
            (self._orderedOpenSet):Remove(id)
            id = (self._orderedOpenSet):Push(y)
            add(pqueue_ids, y.x, y, y, id)
          end
        end
      end
    end
  end
  result = self:ReconstructPath(self._cameFrom, get_or_create(self._cameFrom, closest.x, closest.y))
  do return result, false end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

SpatialAStar.ReconstructPath = function(self, cameFrom, currentNode)
  -- function num : 0_10
  local result = {}
  self:ReconstructPathRecursive(cameFrom, currentNode, result)
  return result
end

SpatialAStar.ReconstructPathRecursive = function(self, cameFrom, currentNode, result)
  -- function num : 0_11 , upvalues : get, _ENV
  local item = get(cameFrom, currentNode.x, currentNode.y)
  if item then
    self:ReconstructPathRecursive(cameFrom, item, result)
    ;
    (table.insert)(result, item)
  else
    ;
    (table.insert)(result, item)
  end
end

SpatialAStar.StoreNeighbors = function(self, around, context)
  -- function num : 0_12 , upvalues : Point, get_or_create
  local result = {}
  local x = around.x
  local y = around.y
  local pt = (Point.Create)(x, y)
  if y > 0 and context:CanWalkAcross(pt, (Point.Create)(x, y - 1)) then
    result[1] = get_or_create(self._searchSpace, x, y - 1)
  end
  if x > 0 and context:CanWalkAcross(pt, (Point.Create)(x - 1, y)) then
    result[2] = get_or_create(self._searchSpace, x - 1, y)
  end
  if x < self._width - 1 and context:CanWalkAcross(pt, (Point.Create)(x + 1, y)) then
    result[3] = get_or_create(self._searchSpace, x + 1, y)
  end
  if y < self._height - 1 and context:CanWalkAcross(pt, (Point.Create)(x, y + 1)) then
    result[4] = get_or_create(self._searchSpace, x, y + 1)
  end
  return result
end

SpatialAStar.Update = function(self, x, y, context)
  -- function num : 0_13 , upvalues : get_or_create
  local node = get_or_create(self._searchSpace, x, y)
  node.context = context
end

return SpatialAStar

