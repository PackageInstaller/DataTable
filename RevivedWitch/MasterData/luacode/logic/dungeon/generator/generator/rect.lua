-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/generator/rect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Rect = class("Rect")
Rect.Ctor = function(self, x, y, width, height)
  -- function num : 0_0
  self._x = x or 0
  self._y = y or 0
  self._width = width
  self._height = height
end

Rect.GetPosition = function(self)
  -- function num : 0_1
  return self._x, self._y
end

Rect.SetPosition = function(self, x, y)
  -- function num : 0_2 , upvalues : _ENV
  assert(x > 0 and y > 0, (debug.traceback)())
  self._x = x
  self._y = y
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Rect.GetCenter = function(self)
  -- function num : 0_3
  return self._x + self._width / 2, self._y + self._height / 2
end

Rect.GetMin = function(self)
  -- function num : 0_4
  return self:GetPosition()
end

Rect.SetMin = function(self, x, y)
  -- function num : 0_5
  self:SetPosition(x, y)
end

Rect.GetMax = function(self)
  -- function num : 0_6
  return self._x + self._width - 1, self._y + self._height - 1
end

Rect.SetMax = function(self, x, y)
  -- function num : 0_7
  self._width = x - self._x + 1
  self._height = y - self._y + 1
end

Rect.GetWidth = function(self)
  -- function num : 0_8
  return self._width
end

Rect.SetWidth = function(self, width)
  -- function num : 0_9
  self._width = width
end

Rect.GetHeight = function(self)
  -- function num : 0_10
  return self._height
end

Rect.SetHeight = function(self, height)
  -- function num : 0_11
  self._height = height
end

Rect.Contains = function(self, pos)
  -- function num : 0_12
  do return self._x <= pos.x and pos.x < self._x + self._width and self._y <= pos.y and pos.y < self._y + self._height end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local overlap = function(lhs, rhs)
  -- function num : 0_13
  do return rhs._x < lhs._x + lhs._width and lhs._x < rhs._x + rhs._width and rhs._y < lhs._y + lhs._height and lhs._y < rhs._y + rhs._height end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Rect.Overlap = function(self, rhs)
  -- function num : 0_14 , upvalues : overlap
  if not overlap(self, rhs) then
    return overlap(rhs, self)
  end
end

return Rect

