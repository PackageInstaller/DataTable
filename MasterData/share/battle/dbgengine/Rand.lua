local Rand = {}
Rand.__index = Rand

function Rand.new(seed)
  local obj = {}
  setmetatable(obj, Rand)
  obj:randomseed(seed)
  return obj
end

function Rand:getstate()
end

function Rand:setstate()
end

function Rand:random(min, max)
  local v
  if max then
    v = math.random(min, max)
  elseif min then
    v = math.random(min)
  else
    v = math.random()
  end
  return v
end

function Rand:randomseed(seed)
  if nil == seed then
    do return math.randomseed, os.time() end
    return math.randomseed, os.time()
  end
  do return math.randomseed end
  return math.randomseed, seed
end

return Rand
