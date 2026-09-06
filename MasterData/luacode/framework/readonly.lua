local metatable = {}

function metatable.__index(ro_table, key)
  local value = ro_table.____ro_raw_table[key]
  if value == nil and type(key) == "table" and key.____ro_raw_table then
    value = ro_table.____ro_raw_table[key.____ro_raw_table]
  end
  return read_only(value)
end

function metatable.__newindex(ro_table, key, value)
  error(string.format("inaccessible due to its readonly. key = %s, value = %s", key, value))
end

function metatable.__pairs(ro_table)
  local pairsIndex
  
  local function read_only_next(raw_table)
    local nk, nv = next(raw_table, pairsIndex)
    pairsIndex = nk
    return read_only(nk), read_only(nv)
  end
  
  return read_only_next, ro_table.____ro_raw_table, nil
end

function metatable.__len(ro_table)
  return #ro_table.____ro_raw_table
end

function metatable.__eq(left, right)
  if type(left) == "table" and left.____ro_raw_table then
    left = left.____ro_raw_table
  end
  if type(right) == "table" and right.____ro_raw_table then
    right = right.____ro_raw_table
  end
  return left == right
end

function metatable.__tostring(ro_table)
  return string.format("readonly %s", ro_table.____ro_raw_table)
end

function read_only(data)
  if type(data) ~= "table" or data.____ro_raw_table then
    return data
  end
  local retValue = {____ro_raw_table = data}
  setmetatable(retValue, metatable)
  return retValue
end

function read_only_cast(data)
  if type(data) ~= "table" or not data.____ro_raw_table then
    return data
  end
  return data.____ro_raw_table
end
