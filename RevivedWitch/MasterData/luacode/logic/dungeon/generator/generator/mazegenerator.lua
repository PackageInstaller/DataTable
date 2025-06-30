-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/generator/mazegenerator.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MazeGenerator = class("MazeGenerator")
local SpatialAStar = require("logic.dungeon.pathfinding.spatialastar")
local Region = require("logic.dungeon.generator.generator.region")
local Point = require("logic.dungeon.generator.delaunay-triangulation.point")
local RoomType = (Region.BlockingType).Room
MazeGenerator.Ctor = function(self, area)
  -- function num : 0_0 , upvalues : SpatialAStar
  self._area = area
  self._finder = (SpatialAStar.Create)(area:GetWidth(), area:GetHeight())
end

MazeGenerator.Init = function(self, bound, start, stop)
  -- function num : 0_1
  self._bound = bound
  self._start = start
  self._stop = stop
end

MazeGenerator.Clear = function(self)
  -- function num : 0_2
  self._bound = nil
  self._start = nil
  self._stop = nil
end

MazeGenerator.Generate = function(self, checkpoint_num)
  -- function num : 0_3 , upvalues : _ENV, Region
  local path = {}
  local pt = clone(self._start)
  local context = {CanWalkAcross = function()
    -- function num : 0_3_0
    return true
  end
, iswalkable = function(ctx, point)
    -- function num : 0_3_1 , upvalues : self
    return self:IsWalkable(point)
  end
}
  local checkpoints = self:GenCheckpoints(checkpoint_num)
  ;
  (table.insert)(checkpoints, self._stop)
  for i,cp in ipairs(checkpoints) do
    local part, succ = (self._finder):Search(pt, cp, context)
    ;
    (table.insertto)(path, part)
    pt = cp
  end
  for k,v in pairs(path) do
    (self._area):Fill(v.x, v.y, (Region.BlockingType).Floor, 0)
  end
  return path
end

MazeGenerator.GenCheckpoints = function(self, num)
  -- function num : 0_4 , upvalues : _ENV, RoomType, Point
  local cps = {}
  local xpos, ypos = (self._bound):GetPosition()
  if (self._bound):GetWidth() < num * 2 and (self._bound):GetHeight() < num * 2 then
    return cps
  end
  local random = (pcg.create)()
  while num ~= 0 do
    local x = random((self._bound):GetWidth()) + xpos
    local y = random((self._bound):GetHeight()) + ypos
    if ((self._area):Get(x, y)).type ~= RoomType then
      (table.insert)(cps, (Point.Create)(x, y))
      num = num - 1
    end
  end
  do
    ;
    (table.sort)(cps, function(lhs, rhs)
    -- function num : 0_4_0 , upvalues : self
    do return (self._start):dist2(lhs) < (self._start):dist2(rhs) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    return cps
  end
end

MazeGenerator.IsWalkable = function(self, point)
  -- function num : 0_5 , upvalues : RoomType
  local cell = (self._area):Get(point.x, point.y)
  if cell.type == RoomType then
    return false
  else
    local width = (self._area):GetWidth()
    local height = (self._area):GetHeight()
    local x = point.x
    local y = point.y
    if x >= 1 and ((self._area):Get(x - 1, y)).type == RoomType then
      return false
    end
    if y >= 1 and ((self._area):Get(x, y - 1)).type == RoomType then
      return false
    end
    if x >= 1 and y >= 1 and ((self._area):Get(x - 1, y - 1)).type == RoomType then
      return false
    end
    if width > x + 1 and ((self._area):Get(x + 1, y)).type == RoomType then
      return false
    end
    if height > y + 1 and ((self._area):Get(x, y + 1)).type == RoomType then
      return false
    end
    if width > x + 1 and height > y + 1 and ((self._area):Get(x + 1, y + 1)).type == RoomType then
      return false
    end
    if x >= 1 and height > y + 1 and ((self._area):Get(x - 1, y + 1)).type == RoomType then
      return false
    end
    if width > x + 1 and y >= 1 and ((self._area):Get(x + 1, y - 1)).type == RoomType then
      return false
    end
    return true
  end
end

return MazeGenerator

