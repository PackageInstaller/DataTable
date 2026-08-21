function fif(condition, positive, negitive)
  if condition then
    return positive
  else
    return negitive
  end
end

function math.clamp(value, min, max)
  return math.min(math.max(value, min), max)
end

function string:starts(pattern)
  return string.sub(self, 1, string.len(pattern)) == pattern
end

function string:ends(pattern)
  return string.sub(self, -string.len(pattern)) == pattern
end

function string:split(splitter)
  local result = {}
  local pattern = "([^" .. splitter .. "]+)"
  string.gsub(self, pattern, function(match)
    table.insert(result, match)
  end)
  return result
end

function string:replace(pattern, replacement)
  local from, to = self:find(pattern, 0, true)
  if from ~= nil and to ~= nil then
    return self:sub(0, from - 1) .. replacement .. self:sub(to + 1)
  else
    return self
  end
end

function string:toarray()
  local result = {}
  for i = 1, self:len() do
    table.insert(result, self:sub(i, i))
  end
  return result
end

function string:trim()
  return (string.gsub(self, "^%s*(.-)%s*$", "%1"))
end

unpack = table.unpack
local __sort = table.sort
local __insert = table.insert

function table:sort(...)
  __sort(self, ...)
  return self
end

function table:insert(...)
  __insert(self, ...)
  return self
end

function table.linq(_table)
  local table_type = type(_table)
  if table_type == "userdata" then
    local csharp_type = _table:GetType()
    if csharp_type.IsArray then
      local new_table = {}
      for i = 0, _table.Length - 1 do
        table.insert(new_table, _table[i])
      end
      _table = new_table
    end
  end
  local mt = getmetatable(_table)
  if mt == nil then
    mt = {
      __index = table,
      __linq = true
    }
  elseif not mt.__linq then
    mt.__linq = true
    if mt.__index == nil then
      mt.__index = table
    elseif assert(type(mt.__index) == "table", "internal", "table with a non-table-typed __index meta can't be linqlize") then
      table.copy(table, mt.__index, false, true)
    end
  end
  return setmetatable(_table, mt)
end

_ENV["!"] = table.linq

function table:slice(start_index, length)
  local end_index = #self
  if length ~= nil then
    end_index = start_index + length
  end
  local result = _ENV["!"]({})
  for i = start_index, end_index do
    table.insert(result, self[i])
  end
  return result
end

function table:join(splitter)
  return table.concat(self, splitter)
end

function table:count()
  if self == nil then
    return 0
  end
  local result = 0
  for k, v in pairs(self) do
    result = result + 1
  end
  return result
end

function table:dump()
  if self ~= nil then
    local visited = {}
    local segs = _ENV["!"]({})
    
    local function print_table_impl(self, indent)
      segs:insert(indent .. "{")
      segs:insert("\n")
      for k, v in pairs(self) do
        if type(k) == "number" then
          segs:insert(string.format("%s  [%s] = ", indent, k))
        else
          segs:insert(string.format("%s  %s = ", indent, k))
        end
        if type(v) == "table" then
          if not visited[v] then
            visited[v] = true
            if table.empty(v) then
              segs:insert("{}")
            else
              segs:insert("\n")
              print_table_impl(v, indent .. "  ")
            end
            segs:insert(",\n")
          end
        elseif type(v) == "string" then
          segs:insert(string.format("\"%s\",\n", v))
        else
          segs:insert(string.format("%s,\n", v))
        end
      end
      segs:insert(indent .. "}")
    end
    
    print_table_impl(self, "")
    return segs:concat("")
  end
end

function table:find(predicate)
  if self ~= nil then
    for key, value in pairs(self) do
      if predicate(key, value) then
        return key, value
      end
    end
  end
end

function table:append(targetTable)
  if targetTable ~= nil then
    for i = 1, #targetTable do
      if targetTable[i] ~= nil then
        table.insert(self, targetTable[i])
      end
    end
  end
  return self
end

function table:keys()
  local keys = _ENV["!"]({})
  for key in pairs(self) do
    table.insert(keys, key)
  end
  return keys
end

function table:values()
  local values = _ENV["!"]({})
  for _, value in pairs(self) do
    table.insert(values, value)
  end
  return values
end

function table:where(predicate)
  local result = _ENV["!"]({})
  for key, value in pairs(self) do
    if predicate(key, value) then
      result[key] = value
    end
  end
  return result
end

function table:select(predicate)
  local result = _ENV["!"]({})
  for key, value in pairs(self) do
    result[key] = predicate(value)
  end
  return result
end

function table:empty()
  for _ in pairs(self) do
    return false
  end
  return true
end

function table:merge(targetTable, ignore_nil)
  if ignore_nil == nil then
    ignore_nil = true
  end
  if targetTable ~= nil then
    for key, value in pairs(targetTable) do
      if ignore_nil or value ~= nil then
        self[key] = value
      end
    end
  end
  return self
end

function table:toarray()
  local result = _ENV["!"]({})
  for _, value in pairs(self) do
    table.insert(result, value)
  end
  return result
end

function table:distinct()
  local result = _ENV["!"]({})
  local mark = {}
  for _, value in pairs(self) do
    if mark[value] == nil then
      table.insert(result, value)
      mark[value] = true
    end
  end
  return result
end

function table:first()
  if 0 < #self then
    return self[1]
  end
end

function table:last()
  if 0 < #self then
    return self[#self]
  end
end

function table:random(exclude)
  local count = #self
  if 1 < count then
    local result
    while result == exclude or result == nil do
      result = self[math.random(1, count)]
    end
    return result
  elseif count == 1 then
    return self[1]
  end
end

function table:copy(_table_to, deep)
  deep = fif(deep == nil, false, true)
  for key, value in pairs(self) do
    local valueType = type(value)
    if valueType == "table" then
      if deep then
        _table_to[key] = table.copy(value, {}, deep)
      else
        _table_to[key] = value
      end
    elseif valueType == "function" then
    else
      _table_to[key] = value
    end
  end
  return _table_to
end

function table:duplicate(deep)
  return self:copy(_ENV["!"]({}), deep)
end

function table:makeLookup(lookup)
  local mt = getmetatable(self)
  local origin_index = mt ~= nil and mt.__index
  
  local function apply(obj, key, index)
    if type(index) == "table" then
      return index[key]
    elseif type(index) == "function" then
      return index(obj, key)
    end
  end
  
  return function(obj, key)
    local result = rawget(self, key)
    if result == nil and origin_index ~= nil then
      result = apply(obj, key, origin_index)
    end
    if result == nil then
      result = apply(obj, key, lookup)
    end
    return result
  end
end

function table:has(value)
  local res = false
  local rk, rv = table.find(self, function(_, v)
    return value == v
  end)
  if rk ~= nil then
    res = true
  end
  return res
end

function table:compare(_comp_to)
  if self ~= _comp_to and _comp_to ~= nil then
    for key, value in pairs(self) do
      if rawget(_comp_to, key) ~= value then
        return false
      end
    end
    for key, value in pairs(_comp_to) do
      if rawget(self, key) ~= value then
        return false
      end
    end
    return true
  end
  return false
end

function table:reduce(func, initVal)
  local result
  if initVal ~= nil then
    result = initVal
  else
    initVal = self[1]
  end
  local start = 2
  if initVal ~= nil then
    start = 1
  end
  for i = start, #self do
    result = func(result, self[i])
  end
  return result
end

function table:reduceOr()
  local result = false
  if self ~= nil then
    for _, v in pairs(self) do
      result = result or v
      if result then
        return true
      end
    end
  end
  return false
end

function table:reverse()
  if self ~= nil then
    local size = #self
    for i = 1, #self / 2 do
      self[i], self[size + 1 - i] = self[size + 1 - i], self[i]
    end
  end
end

function table:filter(key, predicate)
  local result = _ENV["!"]({})
  local bucket = {}
  for k, v in pairs(self) do
    local oldv = bucket[v[key]]
    if oldv == nil then
      bucket[v[key]] = {index = k, value = v}
    elseif predicate(v, oldv.value) then
      bucket[v[key]] = {index = k, value = v}
    end
  end
  for k, v in pairs(bucket) do
    result[v.index] = v.value
  end
  return result
end

function inherit(base_source, derived_env)
  local base_env = createSandbox({
    this = derived_env.this,
    __impl = derived_env
  })
  doChunk(base_source, base_env)
  setmetatable(derived_env, {__index = base_env})
  return base_env
end

function bitCount(number)
  local count = 0
  while number ~= 0 do
    number = number & number - 1
    count = count + 1
  end
  return count
end

function toboolean(value)
  return not not value
end

function isNaN(x)
  return x ~= x
end

function table:shuffle()
  local length = #self
  for i = 1, length do
    self:swap(i, math.random(1, length))
  end
end

function table:swap(i, j)
  local t = self[i]
  self[i] = self[j]
  self[j] = t
end
