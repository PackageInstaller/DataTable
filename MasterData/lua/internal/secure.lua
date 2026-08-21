local pool_size = 10
local secure_prefix = "!"
local secure_mt = {
  __index = function(obj, key)
    local secure_info
    if type(key) == "string" then
      secure_info = rawget(obj, secure_prefix .. key)
    end
    if secure_info ~= nil then
      return secure_info.pool[secure_info.index]
    else
      return rawget(obj, key)
    end
  end,
  __newindex = function(obj, key, value)
    local value_type = type(value)
    if type(key) == "string" and (value_type == "number" or value_type == "boolean") then
      local secure_key = secure_prefix .. key
      if value ~= nil then
        local secure_info = obj[secure_key]
        if secure_info == nil then
          secure_info = {
            index = 0,
            pool = {}
          }
          rawset(obj, secure_key, secure_info)
        end
        local new_index = math.random(1, pool_size)
        secure_info.index = new_index
        secure_info.pool[new_index] = value
      else
        rawset(obj, secure_key, nil)
      end
    else
      rawset(obj, key, value)
    end
  end,
  __pairs = function(obj)
    local plain_obj = {}
    local key, value
    while true do
      key, value = next(obj, key)
      if key ~= nil then
        if key:sub(1, 1) == secure_prefix and value ~= nil and value.pool ~= nil then
          plain_obj[key:sub(2)] = value.pool[value.index]
        else
          plain_obj[key] = value
        end
      else
        break
      end
    end
    return next, plain_obj, nil
  end
}

function secure(data)
  return table.merge(setmetatable({}, _ENV["!"]({}):merge(getmetatable(data)):merge(secure_mt)), data)
end
