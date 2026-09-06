local Rect = class("Rect")

function Rect:Ctor(x, y, width, height)
  self._x = x or 0
  self._y = y or 0
  self._width = width
  self._height = height
end

function Rect:GetPosition()
  return self._x, self._y
end

function Rect:SetPosition(x, y)
  assert(0 < x and 0 < y, debug.traceback())
  self._x = x
  self._y = y
end

function Rect:GetCenter()
  return self._x + self._width / 2, self._y + self._height / 2
end

function Rect:GetMin()
  return self:GetPosition()
end

function Rect:SetMin(x, y)
  self:SetPosition(x, y)
end

function Rect:GetMax()
  return self._x + self._width - 1, self._y + self._height - 1
end

function Rect:SetMax(x, y)
  self._width = x - self._x + 1
  self._height = y - self._y + 1
end

function Rect:GetWidth()
  return self._width
end

function Rect:SetWidth(width)
  self._width = width
end

function Rect:GetHeight()
  return self._height
end

function Rect:SetHeight(height)
  self._height = height
end

function Rect:Contains(pos)
  return self._x <= pos.x and pos.x < self._x + self._width and self._y <= pos.y and pos.y < self._y + self._height
end

local function overlap(lhs, rhs)
  return lhs._x + lhs._width > rhs._x and lhs._x < rhs._x + rhs._width and lhs._y + lhs._height > rhs._y and lhs._y < rhs._y + rhs._height
end

function Rect:Overlap(rhs)
  return overlap(self, rhs) or overlap(rhs, self)
end

return Rect
