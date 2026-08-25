local find, format, sub, gsub = string.find, string.format, string.sub, string.gsub
local tonumber = _ENV.tonumber
local tostring = _ENV.tostring
local tremove = table.remove
local tinsert = table.insert
local setmetatable = _ENV.setmetatable
local select = _ENV.select
local type = _ENV.type
local string = _ENV.string
local min = math.min

local function isReserved(str)
  local c = string.byte(str, 1)
  return 36 == c or 95 == c
end

local function parse_path(path)
  if "string" ~= type(path) or "" == path then
    error("invalid path:" .. tostring(path))
  end
  local result = {}
  local i, n = 1, #path
  while i <= n do
    local s, e, split1, key, split2 = find(path, "([%.%[])([^%.^%[^%]]+)(%]?)", i)
    if not s or i < s then
      tinsert(result, sub(path, i, s and s - 1))
    end
    if not s then
      break
    end
    if "[" == split1 then
      if "]" ~= split2 then
        error("invalid path:" .. path)
      end
      key = tonumber(key)
      if not key then
        error("invalid path:" .. path)
      end
      tinsert(result, key)
    else
      tinsert(result, key)
    end
    i = e + 1
  end
  return result
end

local function createGetter(path, target)
  return path
end

local function createSetter(path, target)
  local keys = parse_path(path)
  local key_len = #keys
  if "function" == type(target) then
    return function(value)
      local obj = target()
      for i, key in ipairs(keys) do
        if not obj then
          return
        end
        if i == key_len then
          obj[key] = value
        else
          obj = obj[key]
        end
      end
    end
  else
    return function(value)
      local obj = target
      for i, key in ipairs(keys) do
        if not obj then
          return
        end
        if i == key_len then
          obj[key] = value
        else
          obj = obj[key]
        end
      end
    end
  end
end

local function removeArrayItem(t, item)
  for i, v in ipairs(t) do
    if v == item then
      tremove(t, i)
      break
    end
  end
end

local function slice(array)
  local newArray = {}
  for i = 1, #array do
    newArray[i] = array[i]
  end
  return newArray
end

local weakInstances = {}
setmetatable(weakInstances, {__mode = "k"})

local function getObjectInstancesStatus()
  local status = {}
  for o in pairs(weakInstances) do
    status[o.__name] = (status[o.__name] or 0) + 1
  end
  return status
end

local function class(name)
  local cls = {}
  cls.__name = name
  cls.__index = cls
  
  function cls.new(...)
    local instance = {}
    weakInstances[instance] = 1
    setmetatable(instance, cls)
    cls.constructor(instance, ...)
    return instance
  end
  
  return cls
end

local function splice(t, index, howMany, ...)
  local removed = {}
  local tableSize = #t
  local args = {
    ...
  }
  local argNb = #args
  if index < 1 then
    index = 1
  end
  if howMany < 0 then
    howMany = 0
  end
  if tableSize < index then
    index = tableSize + 1
    howMany = 0
  end
  if tableSize < index + howMany - 1 then
    howMany = tableSize - index + 1
  end
  local argIdx = 1
  for pos = index, index + min(howMany, argNb) - 1 do
    tinsert(removed, t[pos])
    t[pos] = args[argIdx]
    argIdx = argIdx + 1
  end
  argIdx = argIdx - 1
  for i = 1, howMany - argNb do
    tinsert(removed, tremove(t, index + argIdx))
  end
  for i = argNb - howMany, 1, -1 do
    tinsert(t, index + howMany, args[argIdx + i])
  end
  return removed
end

local function instanceof(obj, cls)
  local mt = obj
  while mt do
    if mt == cls then
      return true
    end
    mt = getmetatable(mt)
  end
  return false
end

return {
  createGetter = createGetter,
  createSetter = createSetter,
  removeArrayItem = removeArrayItem,
  class = class,
  slice = slice,
  splice = splice,
  isReserved = isReserved,
  instanceof = instanceof,
  getObjectInstancesStatus = getObjectInstancesStatus
}
