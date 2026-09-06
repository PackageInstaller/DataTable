local function default_cmp(lhk, lhv, rhk, rhv)
  return lhv == rhv
end

function table.aggregate(source, seed, func)
  for k, v in pairs(source) do
    seed = func(seed, k, v)
  end
  return seed
end

function table.all(source, func)
  for k, v in pairs(source) do
    if not func(k, v) then
      return false
    end
  end
  return true
end

function table.any(source, func)
  for k, v in pairs(source) do
    if func(k, v) then
      return true
    end
  end
  return false
end

function table.average(source)
  return table.sum(source) / #source
end

function table.contains(source, source2, cmp)
  cmp = cmp or default_cmp
  for k, v in pairs(source2) do
    if not table.any(source, function(key, value)
      return cmp(k, v, key, value)
    end) then
      return false
    end
  end
  return true
end

function table.count(source, func)
  func = func or function()
    return true
  end
  local count = 0
  for k, v in pairs(source) do
    if func(k, v) then
      count = count + 1
    end
  end
  return count
end

function table.except(first, second, cmp)
  cmp = cmp or default_cmp
  local only_in_first = {}
  for k, v in pairs(first) do
    if not table.any(second, function(key, value)
      return cmp(k, v, key, value)
    end) then
      only_in_first[k] = v
    end
  end
  return only_in_first
end

function table.first(source, match)
  for k, v in pairs(source) do
    if not match or match(k, v) then
      return k, v
    end
  end
  return nil, nil
end

function table.intersect(first, second, cmp)
  cmp = cmp or default_cmp
  local intersection = {}
  for k, v in pairs(first) do
    if table.any(second, function(key, value)
      return cmp(k, v, key, value)
    end) then
      intersection[k] = v
    end
  end
  return intersection
end

function table.repeat_element(element, count)
  local result = {}
  for i = 1, count do
    table.insert(element, clone(element))
  end
  return result
end

function table.select(source, selector)
  local selected = {}
  for k, v in pairs(source) do
    table.insert(selected, selector(v, k))
  end
  return selected
end

function table.single(source, predict)
  local found = false
  local item
  for k, v in pairs(source) do
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

function table.sum(source)
  local result = 0
  for _, v in pairs(source) do
    result = result + v
  end
  return result
end

function table.todict(source, key_selector, value_selector)
  local result = {}
  for k, v in pairs(source) do
    local key = key_selector(k, v)
    local value = value_selector(k, v)
    result[key] = value
  end
  return result
end

function table.toarray(source)
  local result = {}
  for _, v in pairs(source) do
    table.insert(result, v)
  end
  return result
end

function table.tolist(source)
  local result = {}
  for k, v in pairs(source) do
    table.insert(result, {key = k, value = v})
  end
  return result
end

function table.union(first, second, cmp)
  local result = {}
  cmp = cmp or default_cmp
  for k, v in pairs(first) do
    if table.any(second, function(key, value)
      return cmp(k, v, key, value)
    end) then
      result[k] = v
    end
  end
  return result
end

function table.where(source, predict)
  local result = {}
  for k, v in pairs(source) do
    if predict(k, v) then
      result[k] = v
    end
  end
  return result
end

function table.zip(first, second, result_selector)
  local result = {}
  local min = math.min(#first, #second)
  for i = 1, min do
    table.insert(result, result_selector(first[i], second[i]))
  end
  return result
end
