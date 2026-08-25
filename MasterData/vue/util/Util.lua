local Util = require("Vue.reactivity.reactiveUtils")
local typeof = type
local tinsert = table.insert
local getmetatable = _ENV.getmetatable
local setmetatable = _ENV.setmetatable
local next = _ENV.next
local type = _ENV.type
local pairs = _ENV.pairs
local ipairs = _ENV.ipairs

local function tableReduce(t, f, initValue)
  local total = initValue
  for i, v in ipairs(t) do
    total = f(total, v, i, t)
  end
  return total
end

local function tableConcat(t1, t2)
  local t3 = {}
  for i = 1, #t1 do
    tinsert(t3, t1[i])
  end
  for i = 1, #t2 do
    tinsert(t3, t2[i])
  end
  return t3
end

local function mergeObjects(arr)
  do return tableReduce, arr, function(prev, obj)
    for key, value in pairs(obj) do
      local existing = prev[key]
      if existing then
        if "table" == type(existing) then
          prev[key] = tableConcat(existing, obj[key])
        else
          prev[key] = tableConcat({existing}, obj[key])
        end
      else
        prev[key] = obj[key]
      end
    end
    return prev
  end end
  return tableReduce, arr, function(prev, obj)
    for key, value in pairs(obj) do
      local existing = prev[key]
      if existing then
        if "table" == type(existing) then
          prev[key] = tableConcat(existing, obj[key])
        else
          prev[key] = tableConcat({existing}, obj[key])
        end
      else
        prev[key] = obj[key]
      end
    end
    return prev
  end, {}
end

local function getNestedState(state, nestedKeys)
  do return tableReduce, nestedKeys, function(state, key)
    return state[key]
  end end
  return tableReduce, nestedKeys, function(state, key)
    return state[key]
  end, state
end

local function tableMap(t, fn)
  local newt = {}
  for i, v in pairs(t) do
    newt[i] = fn(i, v)
  end
  return newt
end

local function indexOf(t, v)
  for i = 1, #t do
    if t[i] == v then
      return i
    end
  end
  return 0
end

Util.indexOf = indexOf
Util.mergeObjects = mergeObjects
Util.tableMap = tableMap
Util.tableReduce = tableReduce
Util.tableConcat = tableConcat
Util.getNestedState = getNestedState
Util.mergeObjects = mergeObjects
return Util
