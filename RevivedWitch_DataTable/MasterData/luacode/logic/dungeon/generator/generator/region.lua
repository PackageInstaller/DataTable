-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/generator/region.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Region = class("Region")
local Rect = require("logic.dungeon.generator.generator.rect")
Region.BlockingType = {Empty = 1, Blocking = 2, Floor = 3, Room = 4}
Region.Ctor = function(self, width, height)
  -- function num : 0_0
  self._width = width
  self._height = height
  self._area = {}
end

Region.GetWidth = function(self)
  -- function num : 0_1
  return self._width
end

Region.GetHeight = function(self)
  -- function num : 0_2
  return self._height
end

Region.GetArea = function(self)
  -- function num : 0_3
  return self._area
end

Region.Fill = function(self, x, y, type, index)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

  if not (self._area)[y] then
    (self._area)[y] = {}
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._area)[y])[x] = {x = x, y = y, type = type, index = index}
  end
end

Region.FillRect = function(self, rect, type, index)
  -- function num : 0_5 , upvalues : _ENV
  local x, y = rect:GetPosition()
  print(x, y, type, index)
  for i = y, y + rect:GetHeight() - 1 do
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R10 in 'UnsetPending'

    if not (self._area)[i] then
      (self._area)[i] = {}
      for j = x, x + rect:GetWidth() - 1 do
        -- DECOMPILER ERROR at PC36: Confused about usage of register: R14 in 'UnsetPending'

        ((self._area)[i])[j] = {x = j, y = i, type = type, index = index}
      end
      -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC38: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
end

Region.FillRegion = function(self, x, y, region)
  -- function num : 0_6 , upvalues : Region
  for i = y, y + region:GetHeight() - 1 do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'

    if not (self._area)[i] then
      (self._area)[i] = {}
      for j = x, x + region:GetWidth() - 1 do
        local cell = self:Get(i, j)
        local new = region:Get(i - y, j - x)
        -- DECOMPILER ERROR at PC48: Confused about usage of register: R14 in 'UnsetPending'

        if cell.type ~= (Region.BlockingType).Floor and cell.type ~= (Region.BlockingType).Room then
          ((self._area)[i])[j] = {x = j, y = i, type = new.type, index = new.index}
        end
      end
      -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC50: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
end

Region.Get = function(self, x, y)
  -- function num : 0_7 , upvalues : Region
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if not (self._area)[y] then
    (self._area)[y] = {}
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    if not ((self._area)[y])[x] then
      ((self._area)[y])[x] = {0; x = x, y = y, type = (Region.BlockingType).Empty}
      return ((self._area)[y])[x]
    end
  end
end

Region.Inside = function(self, x, y)
  -- function num : 0_8
  do return x >= 0 and x < self._width and y >= 0 and y < self._height end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return Region

