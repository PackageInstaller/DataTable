local ipairs = _ENV.ipairs
local tinsert, tsort = table.insert, table.sort

local function queue_includes(t, value)
  for i, v in ipairs(t) do
    if v == value then
      return true
    end
  end
  return false
end
