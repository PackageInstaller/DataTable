local M = {}

function M.hash_lenth(tb)
  if not tb then
    return 0
  end
  local count = 0
  for _, _ in pairs(tb) do
    count = count + 1
  end
  return count
end

function M.clear_list(list)
  if not list then
    return
  end
  for i = #list, 1, -1 do
    table.remove(list, i)
  end
end

function M.clear_map(map)
  if not map then
    return
  end
  for key, _ in pairs(map) do
    map[key] = nil
  end
end

function M.connect_list(des_list, scr_list)
  assert(des_list)
  assert(scr_list)
  table.move(scr_list, 1, #scr_list, #des_list + 1, des_list)
end

function M.combine_list(list_a, list_b)
  assert(list_a)
  assert(list_b)
  local result = {}
  table.move(list_a, 1, #list_a, #result + 1, result)
  table.move(list_b, 1, #list_b, #result + 1, result)
  return result
end

function M.connect_map(des_map, scr_map)
  assert(des_map)
  for key, value in pairs(scr_map) do
    assert(not des_map[key])
    des_map[key] = value
  end
end

local function _clone(root)
  local lookup_table = {}
  
  local function _copy(object)
    if type(object) ~= "table" then
      return object
    elseif lookup_table[object] then
      return lookup_table[object]
    end
    local newObject = {}
    lookup_table[object] = newObject
    for key, value in pairs(object) do
      newObject[_copy(key)] = _copy(value)
    end
    return newObject
  end
  
  return _copy(root)
end

function M.copy_table(scr)
  assert(scr)
  return _clone(scr)
end

local function _fill(srcRoot, tarRoot)
  local lookup_table = {}
  local objType
  
  local function _copy(obj, tar)
    objType = type(obj)
    if tar and objType ~= type(tar) then
      return Util.debug_output("表格结构不匹配，对应键将被跳过")
    end
    if "table" ~= objType then
      return tar or obj
    elseif lookup_table[obj] then
      return lookup_table[obj]
    end
    tar = tar or {}
    lookup_table[obj] = tar
    for key, value in pairs(obj) do
      tar[key] = _copy(value, rawget(tar, key))
    end
    return tar
  end
  
  return _copy(srcRoot, tarRoot)
end

function M.fill_table(src, tar, isShallowCopy)
  if type(src) ~= "table" or tar and type(tar) ~= "table" then
    Util.debug_output("输入值不是表格")
    return nil
  end
  if isShallowCopy then
    tar = tar or {}
    for key, value in pairs(src) do
      tar[key] = rawget(tar, key) or value
    end
    return tar
  else
    return _fill(src, tar)
  end
end

function M.table_find(table, target)
  assert(table)
  for key, value in pairs(table) do
    if value == target then
      return key
    end
  end
  return nil
end

function M.table_match(table, func)
  assert(table)
  for _, v in pairs(table) do
    if func(v) then
      return v
    end
  end
  return nil
end

function M.list_walk(list, func)
  if not list then
    return
  end
  for key, value in pairs(list) do
    func(key, value)
  end
end

function M.contains(table, value)
  return table and M.table_find(table, value) ~= nil
end

function M.list_delete_by_value(list, value)
  local len = #list
  local remain_count = len
  for i = len, 1, -1 do
    if list[i] == value then
      table.remove(list, i)
      remain_count = remain_count + 1
    end
  end
  return remain_count
end

function M.list_delete_by_key_value(list, key, value)
  for i = #list, 1, -1 do
    if list[i][key] == value then
      table.remove(list, i)
    end
  end
end

function M.list_delete_by_func(list, func)
  for i = #list, 1, -1 do
    if func(list[i]) then
      table.remove(list, i)
    end
  end
end

function M.list2map(list)
  local out = {}
  for _, v in ipairs(list) do
    out[v] = v
  end
  return out
end

function M.map2list(map, sort_func)
  local out = {}
  for _, v in pairs(map) do
    out[#out + 1] = v
  end
  if sort_func then
    table.sort(out, sort_func)
  end
  return out
end

function M.table_reverse(tab)
  if 0 == #tab then
    return tab
  end
  local out = {}
  for i = #tab, 1, -1 do
    table.insert(out, tab[i])
  end
  return out
end

function M.is_empty(tab)
  return nil == tab or nil == next(tab)
end

function M.deep_compare(t1, t2)
  local type_t1 = type(t1)
  local type_t2 = type(t2)
  if type_t1 ~= type_t2 then
    return false
  end
  if "table" ~= type_t1 then
    return t1 == t2
  end
  if M.hash_lenth(t1) ~= M.hash_lenth(t2) then
    return false
  end
  for key1, value1 in pairs(t1) do
    local value2 = t2[key1]
    if nil == value2 or not M.deep_compare(value1, value2) then
      return false
    end
  end
  for key2, _ in pairs(t2) do
    if nil == t1[key2] then
      return false
    end
  end
  return true
end

function M.random_sort_list(list)
  if M.is_empty(list) then
    return
  end
  for i = #list, 2, -1 do
    local random_index = math.random(1, i)
    local num = list[random_index]
    list[random_index] = list[i]
    list[i] = num
  end
end

function M.format_table(node, ignore_function)
  local cache, stack, output = {}, {}, {}
  local depth = 1
  local output_str = "{\n"
  while true do
    local size = 0
    for k, v in pairs(node) do
      size = size + 1
    end
    local cur_index = 1
    for k, v in pairs(node) do
      if ignore_function and type(v) == "function" then
      elseif nil == cache[node] or cur_index >= cache[node] then
        if string.find(output_str, "}", output_str:len()) then
          output_str = output_str .. ",\n"
        elseif not string.find(output_str, "\n", output_str:len()) then
          output_str = output_str .. "\n"
        end
        table.insert(output, output_str)
        output_str = ""
        local key
        if type(k) == "number" or type(k) == "boolean" then
          key = "[" .. tostring(k) .. "]"
        else
          key = "['" .. tostring(k) .. "']"
        end
        if type(v) == "number" or type(v) == "boolean" then
          output_str = output_str .. string.rep("\t", depth) .. key .. " = " .. tostring(v)
        elseif type(v) == "table" then
          output_str = output_str .. string.rep("\t", depth) .. key .. " = {\n"
          table.insert(stack, node)
          table.insert(stack, v)
          cache[node] = cur_index + 1
          break
        else
          output_str = output_str .. string.rep("\t", depth) .. key .. " = '" .. tostring(v) .. "'"
        end
        if cur_index == size then
          output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}"
        else
          output_str = output_str .. ","
        end
      elseif cur_index == size then
        output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}"
      end
      cur_index = cur_index + 1
    end
    if 0 == size then
      output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}"
    end
    if #stack > 0 then
      node = stack[#stack]
      stack[#stack] = nil
      depth = nil == cache[node] and depth + 1 or depth - 1
    else
      break
    end
  end
  table.insert(output, output_str)
  output_str = table.concat(output)
  return output_str
end

function M.binary_search(list, target_index, need_mach, compare_index_func)
  local start_index, end_index = 1, #list
  while start_index <= end_index do
    local mid = math.floor((start_index + end_index) / 2)
    local current = list[mid]
    local current_index = compare_index_func and compare_index_func(current) or current
    if need_mach and current_index == target_index then
      start_index = mid
      break
    elseif target_index > current_index then
      start_index = mid + 1
    else
      end_index = mid - 1
    end
  end
  return start_index
end

return M
