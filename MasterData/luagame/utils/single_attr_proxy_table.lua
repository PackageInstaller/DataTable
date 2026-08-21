local M = {}
local _floor = math.floor
local DecimalPlacesToKeep = 2

local function calibrationValue(value, valueDecimalPlaces)
  local mult = 10 ^ (valueDecimalPlaces or 0)
  return _floor(value * mult + 0.5) / mult
end

local TABLE_STR = "table"

local function is_table(param)
  return type(param) == TABLE_STR
end

local KEY_WEAK_METATABLE = {__mode = "k"}
local VALUE_WEAK_METATABLE = {__mode = "v"}
local dynamic_key_map = setmetatable({}, KEY_WEAK_METATABLE)
local attr_proxy_table_key_map = setmetatable({}, VALUE_WEAK_METATABLE)
local attr_proxy_table_map = setmetatable({}, KEY_WEAK_METATABLE)

local function encrypt_value(dynamic_key, value)
  if nil == value or value == math.huge or is_table(value) then
    return value
  end
  local int_value = _floor(calibrationValue(value * 10 ^ DecimalPlacesToKeep, DecimalPlacesToKeep))
  local encrypted = int_value ~ dynamic_key
  return encrypted
end

local function decrypt_value(dynamic_key, value)
  if nil == value or value == math.huge or is_table(value) then
    return value
  end
  local decrypted = (value ~ dynamic_key) / 10 ^ DecimalPlacesToKeep
  return decrypted
end

local function pairs_iterator(t_internal, k)
  local key, encrypted_value = next(t_internal, k)
  if nil ~= key then
    local table = attr_proxy_table_key_map[t_internal]
    local dynamic_key = dynamic_key_map[table]
    local decrypted_value = decrypt_value(dynamic_key, encrypted_value)
    return key, decrypted_value
  end
  return nil
end

local function index_func(tbl, key)
  local attr_proxy_table = attr_proxy_table_map[tbl]
  local value = rawget(attr_proxy_table, key)
  local dynamic_key = dynamic_key_map[tbl]
  local decrypted_val = decrypt_value(dynamic_key, value)
  return decrypted_val
end

local function newindex_func(tbl, key, value)
  if value and not is_table(value) then
    value = calibrationValue(value, DecimalPlacesToKeep)
  end
  local dynamic_key = dynamic_key_map[tbl]
  local encrypted_val = encrypt_value(dynamic_key, value)
  local attr_proxy_table = attr_proxy_table_map[tbl]
  rawset(attr_proxy_table, key, encrypted_val)
end

local function pairs_func(tbl)
  local attr_proxy_table = attr_proxy_table_map[tbl]
  return pairs_iterator, attr_proxy_table, nil
end

local mt = {
  __index = index_func,
  __newindex = newindex_func,
  __pairs = pairs_func
}

function M.create_encrypted_table()
  local t = {}
  local attr_proxy_table = {}
  math.randomseed(os.time())
  local dynamic_key = math.random(0, 4294967295)
  dynamic_key_map[t] = dynamic_key
  attr_proxy_table_key_map[attr_proxy_table] = t
  attr_proxy_table_map[t] = attr_proxy_table
  setmetatable(t, mt)
  return t
end

return M
