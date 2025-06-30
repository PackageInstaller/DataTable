-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/table.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
-- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

table.nums = function(t)
  -- function num : 0_0 , upvalues : _ENV
  local count = 0
  for k,v in pairs(t) do
    count = count + 1
  end
  return count
end

-- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

table.slen = function(t)
  -- function num : 0_1 , upvalues : _ENV
  local count = 0
  for k,v in ipairs(t) do
    count = count + 1
  end
  return count
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

table.keys = function(hashtable)
  -- function num : 0_2 , upvalues : _ENV
  local keys = {}
  for k,v in pairs(hashtable) do
    keys[#keys + 1] = k
  end
  return keys
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

table.values = function(hashtable)
  -- function num : 0_3 , upvalues : _ENV
  local values = {}
  for k,v in pairs(hashtable) do
    values[#values + 1] = v
  end
  return values
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

table.merge = function(dest, src)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs(src) do
    dest[k] = v
  end
end

local checkint = function(n)
  -- function num : 0_5 , upvalues : _ENV
  if type(n) ~= "number" then
    return 0
  else
    return n
  end
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

table.insertto = function(dest, src, begin)
  -- function num : 0_6 , upvalues : checkint
  begin = checkint(begin)
  if begin <= 0 then
    begin = #dest + 1
  end
  local len = #src
  for i = 0, len - 1 do
    dest[i + (begin)] = src[i + 1]
  end
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

table.indexof = function(array, value, begin)
  -- function num : 0_7
  for i = begin or 1, #array do
    if array[i] == value then
      return i
    end
  end
  return false
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

table.keyof = function(hashtable, value)
  -- function num : 0_8 , upvalues : _ENV
  for k,v in pairs(hashtable) do
    if v == value then
      return k
    end
  end
  return nil
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

table.removebyvalue = function(array, value, removeall)
  -- function num : 0_9 , upvalues : _ENV
  local c, i, max = 0, 1, #array
  while 1 do
    if i <= max then
      if array[i] == value then
        (table.remove)(array, i)
        c = c + 1
        i = i - 1
        max = max - 1
      end
      if removeall then
        i = i + 1
        -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  return c
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

table.map = function(t, fn)
  -- function num : 0_10 , upvalues : _ENV
  for k,v in pairs(t) do
    t[k] = fn(v, k)
  end
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

table.walk = function(t, fn)
  -- function num : 0_11 , upvalues : _ENV
  for k,v in pairs(t) do
    fn(v, k)
  end
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

table.filter = function(t, fn)
  -- function num : 0_12 , upvalues : _ENV
  for k,v in pairs(t) do
    if not fn(v, k) then
      t[k] = nil
    end
  end
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

table.unique = function(t)
  -- function num : 0_13 , upvalues : _ENV
  local check = {}
  local n = {}
  for k,v in pairs(t) do
    if not check[v] then
      n[k] = v
      check[v] = true
    end
  end
  return n
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

table.isContain = function(t, value)
  -- function num : 0_14 , upvalues : _ENV
  for _,v in ipairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

table.contain = function(t, value)
  -- function num : 0_15 , upvalues : _ENV
  for _,v in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

clone = function(object)
  -- function num : 0_16 , upvalues : _ENV
  local lookup_table = {}
  local _copy = function(object)
    -- function num : 0_16_0 , upvalues : _ENV, lookup_table, _copy
    if type(object) ~= "table" then
      return object
    else
      if lookup_table[object] then
        return lookup_table[object]
      end
    end
    local new_table = {}
    lookup_table[object] = new_table
    local nk, nv = next(object, nil)
    while nk ~= nil do
      new_table[_copy(nk)] = _copy(nv)
      nk = next(object, nk)
    end
    return setmetatable(new_table, getmetatable(object))
  end

  return _copy(object)
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

table.print = function(t)
  -- function num : 0_17 , upvalues : _ENV
  local print_r_cache = {}
  local sub_print_r = function(t, indent)
    -- function num : 0_17_0 , upvalues : print_r_cache, _ENV, sub_print_r
    if print_r_cache[tostring(t)] then
      warn(indent .. "*" .. tostring(t))
    else
      print_r_cache[tostring(t)] = true
      if type(t) == "table" then
        for pos,val in pairs(t) do
          if type(val) == "table" then
            warn(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
            sub_print_r(val, indent .. (string.rep)(" ", (string.len)(pos) + 8))
            warn(indent .. (string.rep)(" ", (string.len)(pos) + 6) .. "}")
          else
            if type(val) == "string" then
              warn(indent .. "[" .. pos .. "] => \"" .. val .. "\"")
            else
              warn(indent .. "[" .. pos .. "] => " .. tostring(val))
            end
          end
        end
      else
        do
          warn(indent .. tostring(t))
        end
      end
    end
  end

  if type(t) == "table" then
    warn(tostring(t) .. " {")
    sub_print_r(t, "  ")
    warn("}")
  else
    sub_print_r(t, "  ")
  end
  warn()
end


