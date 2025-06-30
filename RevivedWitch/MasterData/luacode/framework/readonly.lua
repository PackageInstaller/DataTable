-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/readonly.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local metatable = {}
metatable.__index = function(ro_table, key)
  -- function num : 0_0 , upvalues : _ENV
  local value = (ro_table.____ro_raw_table)[key]
  if value == nil and type(key) == "table" and key.____ro_raw_table then
    value = (ro_table.____ro_raw_table)[key.____ro_raw_table]
  end
  return read_only(value)
end

metatable.__newindex = function(ro_table, key, value)
  -- function num : 0_1 , upvalues : _ENV
  error((string.format)("inaccessible due to its readonly. key = %s, value = %s", key, value))
end

metatable.__pairs = function(ro_table)
  -- function num : 0_2 , upvalues : _ENV
  local pairsIndex = nil
  local read_only_next = function(raw_table)
    -- function num : 0_2_0 , upvalues : _ENV, pairsIndex
    local nk, nv = next(raw_table, pairsIndex)
    pairsIndex = nk
    return read_only(nk), read_only(nv)
  end

  return read_only_next, ro_table.____ro_raw_table, nil
end

metatable.__len = function(ro_table)
  -- function num : 0_3
  return #ro_table.____ro_raw_table
end

metatable.__eq = function(left, right)
  -- function num : 0_4 , upvalues : _ENV
  if type(left) == "table" and left.____ro_raw_table then
    left = left.____ro_raw_table
  end
  if type(right) == "table" and right.____ro_raw_table then
    right = right.____ro_raw_table
  end
  do return left == right end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

metatable.__tostring = function(ro_table)
  -- function num : 0_5 , upvalues : _ENV
  return (string.format)("readonly %s", ro_table.____ro_raw_table)
end

read_only = function(data)
  -- function num : 0_6 , upvalues : _ENV, metatable
  if type(data) ~= "table" or data.____ro_raw_table then
    return data
  end
  local retValue = {____ro_raw_table = data}
  setmetatable(retValue, metatable)
  return retValue
end

read_only_cast = function(data)
  -- function num : 0_7 , upvalues : _ENV
  if type(data) ~= "table" or not data.____ro_raw_table then
    return data
  end
  return data.____ro_raw_table
end


