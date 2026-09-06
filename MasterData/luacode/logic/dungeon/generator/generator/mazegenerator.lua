local MazeGenerator = class("MazeGenerator")
local SpatialAStar = require("logic.dungeon.pathfinding.spatialastar")
local Region = require("logic.dungeon.generator.generator.region")
local Point = require("logic.dungeon.generator.delaunay-triangulation.point")
local RoomType = Region.BlockingType.Room

function MazeGenerator:Ctor(area)
  self._area = area
  self._finder = SpatialAStar.Create(area:GetWidth(), area:GetHeight())
end

function MazeGenerator:Init(bound, start, stop)
  self._bound = bound
  self._start = start
  self._stop = stop
end

function MazeGenerator:Clear()
  self._bound = nil
  self._start = nil
  self._stop = nil
end

function MazeGenerator:Generate(checkpoint_num)
  local path = {}
  local pt = clone(self._start)
  local context = {
    CanWalkAcross = function()
      return true
    end,
    iswalkable = function(ctx, point)
      return self:IsWalkable(point)
    end
  }
  local checkpoints = self:GenCheckpoints(checkpoint_num)
  table.insert(checkpoints, self._stop)
  for i, cp in ipairs(checkpoints) do
    local part, succ = self._finder:Search(pt, cp, context)
    table.insertto(path, part)
    pt = cp
  end
  for k, v in pairs(path) do
    self._area:Fill(v.x, v.y, Region.BlockingType.Floor, 0)
  end
  return path
end

function MazeGenerator:GenCheckpoints(num)
  local cps = {}
  local xpos, ypos = self._bound:GetPosition()
  if self._bound:GetWidth() < num * 2 and self._bound:GetHeight() < num * 2 then
    return cps
  end
  local random = pcg.create()
  while num ~= 0 do
    local x = random(self._bound:GetWidth()) + xpos
    local y = random(self._bound:GetHeight()) + ypos
    if self._area:Get(x, y).type ~= RoomType then
      table.insert(cps, Point.Create(x, y))
      num = num - 1
    end
  end
  table.sort(cps, function(lhs, rhs)
    return self._start:dist2(lhs) < self._start:dist2(rhs)
  end)
  return cps
end

function MazeGenerator:IsWalkable(point)
  local cell = self._area:Get(point.x, point.y)
  if cell.type == RoomType then
    return false
  else
    local width = self._area:GetWidth()
    local height = self._area:GetHeight()
    local x = point.x
    local y = point.y
    if not (x < 1) and self._area:Get(x - 1, y).type == RoomType then
      return false
    end
    if not (y < 1) and self._area:Get(x, y - 1).type == RoomType then
      return false
    end
    if not (x < 1) and not (y < 1) and self._area:Get(x - 1, y - 1).type == RoomType then
      return false
    end
    if not (width <= x + 1) and self._area:Get(x + 1, y).type == RoomType then
      return false
    end
    if not (height <= y + 1) and self._area:Get(x, y + 1).type == RoomType then
      return false
    end
    if not (width <= x + 1) and not (height <= y + 1) and self._area:Get(x + 1, y + 1).type == RoomType then
      return false
    end
    if not (x < 1) and not (height <= y + 1) and self._area:Get(x - 1, y + 1).type == RoomType then
      return false
    end
    if not (width <= x + 1) and not (y < 1) and self._area:Get(x + 1, y - 1).type == RoomType then
      return false
    end
    return true
  end
end

return MazeGenerator
