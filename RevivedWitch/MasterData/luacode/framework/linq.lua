-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/linq.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local default_cmp = function(lhk, lhv, rhk, rhv)
  -- function num : 0_0
  do return lhv == rhv end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

table.aggregate = function(source, seed, func)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs(source) do
    seed = func(seed, k, v)
  end
  return seed
end

-- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

table.all = function(source, func)
  -- function num : 0_2 , upvalues : _ENV
  for k,v in pairs(source) do
    if not func(k, v) then
      return false
    end
  end
  return true
end

-- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

table.any = function(source, func)
  -- function num : 0_3 , upvalues : _ENV
  for k,v in pairs(source) do
    if func(k, v) then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

table.average = function(source)
  -- function num : 0_4 , upvalues : _ENV
  return (table.sum)(source) / #source
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

table.contains = function(source, source2, cmp)
  -- function num : 0_5 , upvalues : default_cmp, _ENV
  if not cmp then
    cmp = default_cmp
  end
  for k,v in pairs(source2) do
    do
      if not (table.any)(source, function(key, value)
    -- function num : 0_5_0 , upvalues : cmp, k, v
    return cmp(k, v, key, value)
  end
) then
        return false
      end
    end
  end
  return true
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

table.count = function(source, func)
  -- function num : 0_6 , upvalues : _ENV
  if not func then
    func = function()
    -- function num : 0_6_0
    return true
  end

  end
  local count = 0
  for k,v in pairs(source) do
    if func(k, v) then
      count = count + 1
    end
  end
  return count
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

table.except = function(first, second, cmp)
  -- function num : 0_7 , upvalues : default_cmp, _ENV
  if not cmp then
    cmp = default_cmp
  end
  local only_in_first = {}
  for k,v in pairs(first) do
    do
      if not (table.any)(second, function(key, value)
    -- function num : 0_7_0 , upvalues : cmp, k, v
    return cmp(k, v, key, value)
  end
) then
        only_in_first[k] = v
      end
    end
  end
  return only_in_first
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

table.first = function(source, match)
  -- function num : 0_8 , upvalues : _ENV
  for k,v in pairs(source) do
    if not match or match(k, v) then
      return k, v
    end
  end
  return nil, nil
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

table.intersect = function(first, second, cmp)
  -- function num : 0_9 , upvalues : default_cmp, _ENV
  if not cmp then
    cmp = default_cmp
  end
  local intersection = {}
  for k,v in pairs(first) do
    do
      if (table.any)(second, function(key, value)
    -- function num : 0_9_0 , upvalues : cmp, k, v
    return cmp(k, v, key, value)
  end
) then
        intersection[k] = v
      end
    end
  end
  return intersection
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

table.repeat_element = function(element, count)
  -- function num : 0_10 , upvalues : _ENV
  local result = {}
  for i = 1, count do
    (table.insert)(element, clone(element))
  end
  return result
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

table.select = function(source, selector)
  -- function num : 0_11 , upvalues : _ENV
  local selected = {}
  for k,v in pairs(source) do
    (table.insert)(selected, selector(v, k))
  end
  return selected
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

table.single = function(source, predict)
  -- function num : 0_12 , upvalues : _ENV
  local found = false
  local item = nil
  for k,v in pairs(source) do
    if predict(k, v) then
      if found == true then
        return item, false
      end
      item = v
      found = true
    end
  end
  return item, found
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

table.sum = function(source)
  -- function num : 0_13 , upvalues : _ENV
  local result = 0
  for _,v in pairs(source) do
    result = result + v
  end
  return result
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

table.todict = function(source, key_selector, value_selector)
  -- function num : 0_14 , upvalues : _ENV
  local result = {}
  for k,v in pairs(source) do
    local key = key_selector(k, v)
    local value = value_selector(k, v)
    result[key] = value
  end
  return result
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

table.toarray = function(source)
  -- function num : 0_15 , upvalues : _ENV
  local result = {}
  for _,v in pairs(source) do
    (table.insert)(result, v)
  end
  return result
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

table.tolist = function(source)
  -- function num : 0_16 , upvalues : _ENV
  local result = {}
  for k,v in pairs(source) do
    (table.insert)(result, {key = k, value = v})
  end
  return result
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

table.union = function(first, second, cmp)
  -- function num : 0_17 , upvalues : default_cmp, _ENV
  local result = {}
  if not cmp then
    cmp = default_cmp
  end
  for k,v in pairs(first) do
    do
      if (table.any)(second, function(key, value)
    -- function num : 0_17_0 , upvalues : cmp, k, v
    return cmp(k, v, key, value)
  end
) then
        result[k] = v
      end
    end
  end
  return result
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

table.where = function(source, predict)
  -- function num : 0_18 , upvalues : _ENV
  local result = {}
  for k,v in pairs(source) do
    if predict(k, v) then
      result[k] = v
    end
  end
  return result
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R1 in 'UnsetPending'

table.zip = function(first, second, result_selector)
  -- function num : 0_19 , upvalues : _ENV
  local result = {}
  local min = (math.min)(#first, #second)
  for i = 1, min do
    (table.insert)(result, result_selector(first[i], second[i]))
  end
  return result
end


