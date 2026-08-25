local Rand = {}
Rand.__index = Rand

function Rand.new(seed, battleEngine)
  local Rand_C = require("rand")
  local obj = {
    battleEngine = battleEngine,
    crand = Rand_C.new(seed)
  }
  setmetatable(obj, Rand)
  return obj
end

function Rand:getstate()
  do return self.crand.getstate end
  return self.crand.getstate, self.crand
end

function Rand:setstate(state)
  self.crand:setstate(state)
end

function Rand:random(min, max)
  local crand = self.crand
  local v
  if max then
    v = crand:random(min, max)
  elseif min then
    v = crand:random(min)
  else
    v = crand:random()
  end
  return v
end

function Rand:randomseed(seed)
  local crand = self.crand
  if nil == seed then
    do return crand.randomseed, crand, os.time() end
    return crand.randomseed, crand, os.time()
  end
  do return crand.randomseed, crand end
  return crand.randomseed, crand, seed
end

return Rand
