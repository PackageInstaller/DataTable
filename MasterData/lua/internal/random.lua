local modulus = 1048576
local multiplier = 9
local increment = 7
local R = {}

function R:next(min, max)
  self.v = (multiplier * self.v + increment) % modulus
  if min ~= nil and max ~= nil then
    return self.v % (max - min + 1) + min
  else
    return self.v / modulus
  end
end

function R:getSeed()
  return self.v
end

function R:setSeed(seed)
  self.v = seed
end

function R:new(seed)
  return setmetatable({v = seed}, {__index = self})
end

return R
