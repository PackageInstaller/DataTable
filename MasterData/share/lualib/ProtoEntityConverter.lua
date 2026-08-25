local ProtoEntityConverter = {}

local function _IsValidFieldMap(fieldMap)
  if type(fieldMap) ~= "table" then
    return false
  end
  return nil ~= fieldMap[1]
end

function ProtoEntityConverter.ToArray(obj, fieldMap)
  if not obj or not _IsValidFieldMap(fieldMap) then
    return {}
  end
  local arr = {}
  for i = 1, #fieldMap do
    local fieldName = fieldMap[i]
    arr[i] = obj[fieldName]
  end
  return arr
end

function ProtoEntityConverter.ToObject(arr, fieldMap)
  if not arr or not _IsValidFieldMap(fieldMap) then
    return {}
  end
  local obj = {}
  for i = 1, #fieldMap do
    local fieldName = fieldMap[i]
    obj[fieldName] = arr[i]
  end
  return obj
end

function ProtoEntityConverter.BatchToArray(objList, fieldMap)
  if not objList or not _IsValidFieldMap(fieldMap) then
    return {}
  end
  local result = {}
  for _, obj in pairs(objList) do
    table.insert(result, ProtoEntityConverter.ToArray(obj, fieldMap))
  end
  return result
end

function ProtoEntityConverter.BatchToObject(arrList, fieldMap)
  if not arrList or not _IsValidFieldMap(fieldMap) then
    return {}
  end
  local result = {}
  for _, arr in pairs(arrList) do
    table.insert(result, ProtoEntityConverter.ToObject(arr, fieldMap))
  end
  return result
end

return ProtoEntityConverter
