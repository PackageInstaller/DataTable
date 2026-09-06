local Region = class("Region")
local Rect = require("logic.dungeon.generator.generator.rect")
Region.BlockingType = {
  Empty = 1,
  Blocking = 2,
  Floor = 3,
  Room = 4
}

function Region:Ctor(width, height)
  self._width = width
  self._height = height
  self._area = {}
end

function Region:GetWidth()
  return self._width
end

function Region:GetHeight()
  return self._height
end

function Region:GetArea()
  return self._area
end

function Region:Fill(x, y, type, index)
  self._area[y] = self._area[y] or {}
  self._area[y][x] = {
    x = x,
    y = y,
    type = type,
    index = index
  }
end

function Region:FillRect(rect, type, index)
  local x, y = rect:GetPosition()
  print(x, y, type, index)
  for i = y, y + rect:GetHeight() - 1 do
    self._area[i] = self._area[i] or {}
    for j = x, x + rect:GetWidth() - 1 do
      self._area[i][j] = {
        x = j,
        y = i,
        type = type,
        index = index
      }
    end
  end
end

function Region:FillRegion(x, y, region)
  for i = y, y + region:GetHeight() - 1 do
    self._area[i] = self._area[i] or {}
    for j = x, x + region:GetWidth() - 1 do
      local cell = self:Get(i, j)
      local new = region:Get(i - y, j - x)
      if cell.type ~= Region.BlockingType.Floor and cell.type ~= Region.BlockingType.Room then
        self._area[i][j] = {
          x = j,
          y = i,
          type = new.type,
          index = new.index
        }
      end
    end
  end
end

function Region:Get(x, y)
  self._area[y] = self._area[y] or {}
  self._area[y][x] = self._area[y][x] or {
    x = x,
    y = y,
    type = Region.BlockingType.Empty,
    0
  }
  return self._area[y][x]
end

function Region:Inside(x, y)
  return 0 <= x and x < self._width and 0 <= y and y < self._height
end

return Region
