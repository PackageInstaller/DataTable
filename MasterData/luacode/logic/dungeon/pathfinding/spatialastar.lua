local SpatialAStar = class("SpatialAStar")
local Point = require("logic.dungeon.generator.delaunay-triangulation.point")
local PQueue = require("framework.pqueue")

function SpatialAStar:Ctor(width, height)
  self._width = width
  self._height = height
  self._searchSpace = {}
  self._closeset = {}
  self._openset = {}
  self._cameFrom = {}
  self._runtimeGrid = {}
  self._orderedOpenSet = PQueue.Create():Init(function(lhs, rhs)
    return lhs.F < rhs.F
  end)
end

local function add(tbl, x, y, value)
  tbl[y] = tbl[y] or {}
  tbl[y][x] = value
end

local function remove(tbl, x, y)
  if tbl[y] then
    tbl[y][x] = nil
  end
end

local function get_or_create(tbl, x, y)
  tbl[y] = tbl[y] or {}
  tbl[y][x] = tbl[y][x] or {
    x = x,
    y = y,
    F = 0,
    G = 0,
    H = 0
  }
  return tbl[y][x]
end

local function get(tbl, x, y)
  if tbl[y] then
    return tbl[y][x]
  end
  return nil
end

local function contains(tbl, x, y)
  if tbl[y] then
    return tbl[y][x] ~= nil
  end
  return false
end

local function empty(tbl)
  for k, v in pairs(tbl) do
    for _, vv in pairs(v) do
      return false
    end
  end
  return true
end

function SpatialAStar:Heuristic(start, stop)
  return self:NeighborDistance(start, stop)
end

function SpatialAStar:NeighborDistance(start, stop)
  return math.abs(start.x - stop.x) + math.abs(start.y - stop.y)
end

function SpatialAStar:Search(start, stop, context)
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
  self._orderedOpenSet = PQueue.Create():Init(function(lhs, rhs)
    return lhs.F < rhs.F
  end)
  start_node.G = 0
  start_node.H = self:Heuristic(start_node, stop_node)
  start_node.F = start_node.H
  add(self._openset, start_node.x, start_node.y, start_node)
  self._orderedOpenSet:Push(start_node)
  add(self._runtimeGrid, start_node.x, start_node.y, start_node)
  local closest
  while not empty(self._openset) do
    local x = self._orderedOpenSet:Pop()
    if x.x == stop_node.x and x.y == stop_node.y then
      result = self:ReconstructPath(self._cameFrom, get_or_create(self._cameFrom, stop_node.x, stop_node.y))
      table.insert(result, stop)
      return result, true
    end
    remove(self._openset, x.x, x.y)
    add(self._closeset, x.x, x.y, x)
    neighbors = self:StoreNeighbors(x, context)
    for _, y in pairs(neighbors) do
      local tentativeIsBetter = false
      if context:iswalkable(y) and not contains(self._closeset, y.x, y.y) then
        local tentativeGScore = get_or_create(self._runtimeGrid, x.x, x.y).G + self:NeighborDistance(x, y)
        local wasAdded = false
        if not contains(self._openset, y.x, y.y) then
          add(self._openset, y.x, y.y, y)
          tentativeIsBetter = true
          wasAdded = true
        else
          tentativeIsBetter = tentativeGScore < get_or_create(self._runtimeGrid, y.x, y.y).G
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
            local id = self._orderedOpenSet:Push(y)
            add(pqueue_ids, y.x, y, y, id)
          else
            local id = get_or_create(pqueue_ids, y.x, y.y)
            self._orderedOpenSet:Remove(id)
            id = self._orderedOpenSet:Push(y)
            add(pqueue_ids, y.x, y, y, id)
          end
        end
      end
    end
  end
  result = self:ReconstructPath(self._cameFrom, get_or_create(self._cameFrom, closest.x, closest.y))
  return result, false
end

function SpatialAStar:ReconstructPath(cameFrom, currentNode)
  local result = {}
  self:ReconstructPathRecursive(cameFrom, currentNode, result)
  return result
end

function SpatialAStar:ReconstructPathRecursive(cameFrom, currentNode, result)
  local item = get(cameFrom, currentNode.x, currentNode.y)
  if item then
    self:ReconstructPathRecursive(cameFrom, item, result)
    table.insert(result, item)
  else
    table.insert(result, item)
  end
end

function SpatialAStar:StoreNeighbors(around, context)
  local result = {}
  local x = around.x
  local y = around.y
  local pt = Point.Create(x, y)
  if 0 < y and context:CanWalkAcross(pt, Point.Create(x, y - 1)) then
    result[1] = get_or_create(self._searchSpace, x, y - 1)
  end
  if 0 < x and context:CanWalkAcross(pt, Point.Create(x - 1, y)) then
    result[2] = get_or_create(self._searchSpace, x - 1, y)
  end
  if x < self._width - 1 and context:CanWalkAcross(pt, Point.Create(x + 1, y)) then
    result[3] = get_or_create(self._searchSpace, x + 1, y)
  end
  if y < self._height - 1 and context:CanWalkAcross(pt, Point.Create(x, y + 1)) then
    result[4] = get_or_create(self._searchSpace, x, y + 1)
  end
  return result
end

function SpatialAStar:Update(x, y, context)
  local node = get_or_create(self._searchSpace, x, y)
  node.context = context
end

return SpatialAStar
