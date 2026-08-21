-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dungeon/generator/delaunay-triangulation/point.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
require("logic.dungeon.generator.delaunay-triangulation.functions")
local Point = class("Point")
local Direction = {T = 1, R = 2, L = 3, B = 4}
local cmp = function(lhs, rhs)
  -- function num : 0_0
  do return lhs.x == rhs.x and lhs.y == rhs.y end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local add = function(lhs, rhs)
  -- function num : 0_1 , upvalues : Point
  return (Point.Create)(lhs.x + rhs.x, lhs.y + rhs.y)
end

local mul = function(pt, num)
  -- function num : 0_2 , upvalues : Point
  return (Point.Create)(pt.x * num, pt.y * num)
end

local tos = function(pt)
  -- function num : 0_3
  return ("Point (%s) x: %d y: %d"):format(pt.id, pt.x, pt.y)
end

Point.Ctor = function(self, x, y)
  -- function num : 0_4 , upvalues : _ENV, cmp, add, mul, tos
  self.x = (math.tointeger)(x) or 0
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.class).__eq = cmp
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.class).__add = add
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.class).__mul = mul
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.class).__tostring = tos
end

Point.dist2 = function(self, p)
  -- function num : 0_5
  local dx, dy = self.x - p.x, self.y - p.y
  return dx * dx + dy * dy
end

Point.dist = function(self, p)
  -- function num : 0_6 , upvalues : _ENV
  return (math.sqrt)(self:dist2(p))
end

Point.isInCircle = function(self, cx, cy, r)
  -- function num : 0_7
  local dx = cx - self.x
  local dy = cy - self.y
  do return dx * dx + dy * dy <= r * r end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Point.same = function(self, p)
  -- function num : 0_8
  do return self.x == p.x and self.y == p.y end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Point.Advance = function(self, dir)
  -- function num : 0_9 , upvalues : Direction, Point
  if dir == Direction.T then
    return (Point.Create)(self.x, self.y - 1)
  else
    if dir == Direction.B then
      return (Point.Create)(self.x, self.y + 1)
    else
      if dir == Direction.L then
        return (Point.Create)(self.x - 1, self.y)
      else
        if dir == Direction.R then
          return (Point.Create)(self.x + 1, self.y)
        end
      end
    end
  end
end

return Point

