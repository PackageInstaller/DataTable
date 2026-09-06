function table.nums(t)
  local count = 0
  
  for k, v in pairs(t) do
    count = count + 1
  end
  return count
end

function table.slen(t)
  local count = 0
  for k, v in ipairs(t) do
    count = count + 1
  end
  return count
end

function table.keys(hashtable)
  local keys = {}
  for k, v in pairs(hashtable) do
    keys[#keys + 1] = k
  end
  return keys
end

function table.values(hashtable)
  local values = {}
  for k, v in pairs(hashtable) do
    values[#values + 1] = v
  end
  return values
end

function table.merge(dest, src)
  for k, v in pairs(src) do
    dest[k] = v
  end
end

local function checkint(n)
  if type(n) ~= "number" then
    return 0
  else
    return n
  end
end

function table.insertto(dest, src, begin)
  begin = checkint(begin)
  if begin <= 0 then
    begin = #dest + 1
  end
  local len = #src
  for i = 0, len - 1 do
    dest[i + begin] = src[i + 1]
  end
end

function table.indexof(array, value, begin)
  for i = begin or 1, #array do
    if array[i] == value then
      return i
    end
  end
  return false
end

function table.keyof(hashtable, value)
  for k, v in pairs(hashtable) do
    if v == value then
      return k
    end
  end
  return nil
end

function table.removebyvalue(array, value, removeall)
  local c, i, max = 0, 1, #array
  while i <= max do
    if array[i] == value then
      table.remove(array, i)
      c = c + 1
      i = i - 1
      max = max - 1
      if not removeall then
        break
      end
    end
    i = i + 1
  end
  return c
end

function table.map(t, fn)
  for k, v in pairs(t) do
    t[k] = fn(v, k)
  end
end

function table.walk(t, fn)
  for k, v in pairs(t) do
    fn(v, k)
  end
end

function table.filter(t, fn)
  for k, v in pairs(t) do
    if not fn(v, k) then
      t[k] = nil
    end
  end
end

function table.unique(t)
  local check = {}
  local n = {}
  for k, v in pairs(t) do
    if not check[v] then
      n[k] = v
      check[v] = true
    end
  end
  return n
end

function table.isContain(t, value)
  for _, v in ipairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

function table.contain(t, value)
  for _, v in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

function clone(object)
  local lookup_table = {}
  
  local function _copy(object)
    if type(object) ~= "table" then
      return object
    elseif lookup_table[object] then
      return lookup_table[object]
    end
    local new_table = {}
    lookup_table[object] = new_table
    local nk, nv = next(object, nil)
    while nk ~= nil do
      new_table[_copy(nk)] = _copy(nv)
      nk, nv = next(object, nk)
    end
    return setmetatable(new_table, getmetatable(object))
  end
  
  return _copy(object)
end

function table.print(t)
  local print_r_cache = {}
  
  local function sub_print_r(t, indent)
    if print_r_cache[tostring(t)] then
      warn(indent .. "*" .. tostring(t))
    else
      print_r_cache[tostring(t)] = true
      if type(t) == "table" then
        for pos, val in pairs(t) do
          if type(val) == "table" then
            warn(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
            sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 8))
            warn(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
          elseif type(val) == "string" then
            warn(indent .. "[" .. pos .. "] => \"" .. val .. "\"")
          else
            warn(indent .. "[" .. pos .. "] => " .. tostring(val))
          end
        end
      else
        warn(indent .. tostring(t))
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
