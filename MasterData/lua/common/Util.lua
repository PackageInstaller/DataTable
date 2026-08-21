local U = {
  AttrColorTable = {
    White = "#FFFFFF",
    Title = "#5375A9",
    Value = "#295085",
    Positive = "#0093E5",
    Negative = "#F95C61",
    Disabled = "#7C879F",
    SubTitle = "#c2d5f0"
  },
  GuildShopId = 12
}
local PB = require("Common/PbHelper")

function U.trim(s)
  return (s:gsub("^%s*(.*)%s*$", "%1"))
end

function U.GetAttrValue(attrs, vType)
  if attrs ~= nil then
    for i = 1, #attrs do
      if attrs[i].type == CS.System.Convert.ToInt32(vType) then
        return attrs[i].value
      end
    end
  end
  return 0
end

function U.FormatAttrValue(attr)
  if type(attr.value) == "number" then
    if attr.isRatio and attr.isRatio ~= 0 then
      return string.format("%.2f%%", attr.value / 100)
    else
      return string.format("%d", attr.value)
    end
  else
    return tostring(attr.value)
  end
end

function U.FormatAttrAdd(attr1, attr2)
  local function match(val1, val2)
    if val1 == val2 then
      return true
    end
    if val1 == false and val2 == nil or val1 == nil and val2 == false then
      return true
    end
    return false
  end
  
  if not match(attr1.type, attr2.type) or not match(attr1.isRatio, attr2.isRatio) then
    warning("attr not match!")
    return 0
  end
  local result = {
    type = attr1.type,
    value = attr1.value + attr2.value,
    isRatio = attr1.isRatio
  }
  return U.FormatAttrValue(result)
end

function U.EnumToString(value)
  return string.match(tostring(value), "%a+")
end

function U.EnumToIndex(value)
  return tonumber(string.match(tostring(value), "%d+"))
end

function U.ToEnum(type, value)
  return CS.System.Enum.ToObject(typeof(type), value)
end

function U.ToInt(data)
  return CS.System.Convert.ToInt32(data)
end

function U.MakeBitset(...)
  local result = 0
  local values = {
    ...
  }
  for i = 1, #values do
    result = result | U.ToInt(values[i])
  end
  return result
end

function U.SplitStr(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  local i = 1
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

function U.BinaryMode(number)
  local text = ""
  if number ~= nil then
    while 0 < number do
      text = tostring(number % 2) .. text
      number = number // 2
    end
  end
  return text
end

function U.Translate(transform, x, y, z)
  local old = transform.localPosition
  local new = CS.UnityEngine.Vector3(old.x + x, old.y + y, old.z + z)
  transform.localPosition = new
end

function U.IsTimeOpen(openTime)
  local isOpen = false
  if openTime == nil or openTime == "" then
    isOpen = true
  else
    openTime = CS.GameTime.ServerTimeStrToUtc(openTime)
    local now = CS.GameTime.serverUtc
    if openTime <= now then
      isOpen = true
    end
  end
  return isOpen
end

function U.IsSameYear(time1, time2)
  local t1 = CS.GameTime.UtcToLocal(time1)
  local t2 = CS.GameTime.UtcToLocal(time2)
  return t1.Year == t2.Year
end

function U.ListElementIsSame(list1, list2)
  if list1 == nil or list2 == nil then
    return false
  end
  if #list1 ~= #list2 then
    return false
  end
  local d = {}
  for _, v in pairs(list1) do
    d[v] = true
  end
  for _, v in pairs(list2) do
    if not d[v] then
      return false
    end
  end
  return true
end

return U
