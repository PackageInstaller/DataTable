require("logic.dungeon.generator.delaunay-triangulation.functions")
local Point = class("Point")
local Direction = {
  T = 1,
  R = 2,
  L = 3,
  B = 4
}

local function cmp(lhs, rhs)
  return lhs.x == rhs.x and lhs.y == rhs.y
end

local function add(lhs, rhs)
  return Point.Create(lhs.x + rhs.x, lhs.y + rhs.y)
end

local function mul(pt, num)
  return Point.Create(pt.x * num, pt.y * num)
end

local function tos(pt)
  return ("Point (%s) x: %d y: %d"):format(pt.id, pt.x, pt.y)
end

function Point:Ctor(x, y)
  self.x, self.y, self.id = math.tointeger(x) or 0, math.tointeger(y) or 0, "?"
  self.class.__eq = cmp
  self.class.__add = add
  self.class.__mul = mul
  self.class.__tostring = tos
end

function Point:dist2(p)
  local dx, dy = self.x - p.x, self.y - p.y
  return dx * dx + dy * dy
end

function Point:dist(p)
  return math.sqrt(self:dist2(p))
end

function Point:isInCircle(cx, cy, r)
  local dx = cx - self.x
  local dy = cy - self.y
  return dx * dx + dy * dy <= r * r
end

function Point:same(p)
  return self.x == p.x and self.y == p.y
end

function Point:Advance(dir)
  if dir == Direction.T then
    return Point.Create(self.x, self.y - 1)
  elseif dir == Direction.B then
    return Point.Create(self.x, self.y + 1)
  elseif dir == Direction.L then
    return Point.Create(self.x - 1, self.y)
  elseif dir == Direction.R then
    return Point.Create(self.x + 1, self.y)
  end
end

return Point
