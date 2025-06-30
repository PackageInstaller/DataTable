-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/json.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local json = {_version = "0.1.1"}
local encode = nil
local escape_char_map = {["\\"] = "\\\\", ["\""] = "\\\"", ["\b"] = "\\b", ["\f"] = "\\f", ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t"}
local escape_char_map_inv = {["\\/"] = "/"}
for k,v in pairs(escape_char_map) do
  escape_char_map_inv[v] = k
end
local escape_char = function(c)
  -- function num : 0_0 , upvalues : escape_char_map, _ENV
  if not escape_char_map[c] then
    return (string.format)("\\u%04x", c:byte())
  end
end

local encode_nil = function(val)
  -- function num : 0_1
  return "null"
end

local encode_table = function(val, stack)
  -- function num : 0_2 , upvalues : _ENV, encode
  local res = {}
  if not stack then
    stack = {}
  end
  if stack[val] then
    error("circular reference")
  end
  stack[val] = true
  if val[1] ~= nil or next(val) == nil then
    local n = 0
    for k in pairs(val) do
      if type(k) ~= "number" then
        error("invalid table: mixed or invalid key types")
      end
      n = n + 1
    end
    if n ~= #val then
      error("invalid table: sparse array")
    end
    for i,v in ipairs(val) do
      (table.insert)(res, encode(v, stack))
    end
    stack[val] = nil
    return "[" .. (table.concat)(res, ",") .. "]"
  else
    do
      for k,v in pairs(val) do
        if type(k) ~= "string" then
          error("invalid table: mixed or invalid key types")
        end
        ;
        (table.insert)(res, encode(k, stack) .. ":" .. encode(v, stack))
      end
      stack[val] = nil
      do return "{" .. (table.concat)(res, ",") .. "}" end
    end
  end
end

local encode_string = function(val)
  -- function num : 0_3 , upvalues : escape_char
  return "\"" .. val:gsub("[%z\001-\031\\\"]", escape_char) .. "\""
end

local encode_number = function(val)
  -- function num : 0_4 , upvalues : _ENV
  if val ~= val or val <= -math.huge or math.huge <= val then
    error("unexpected number value \'" .. tostring(val) .. "\'")
  end
  return (string.format)("%.14g", val)
end

local type_func_map = {["nil"] = encode_nil, table = encode_table, string = encode_string, number = encode_number, boolean = tostring}
encode = function(val, stack)
  -- function num : 0_5 , upvalues : _ENV, type_func_map
  local t = type(val)
  local f = type_func_map[t]
  if f then
    return f(val, stack)
  end
  error("unexpected type \'" .. t .. "\'")
end

json.encode = function(val)
  -- function num : 0_6 , upvalues : encode
  return encode(val)
end

local parse = nil
local create_set = function(...)
  -- function num : 0_7 , upvalues : _ENV
  local res = {}
  for i = 1, select("#", ...) do
    res[select(i, ...)] = true
  end
  return res
end

local space_chars = create_set(" ", "\t", "\r", "\n")
local delim_chars = create_set(" ", "\t", "\r", "\n", "]", "}", ",")
local escape_chars = create_set("\\", "/", "\"", "b", "f", "n", "r", "t", "u")
local literals = create_set("true", "false", "null")
local literal_map = {["true"] = true, ["false"] = false, null = nil}
local next_char = function(str, idx, set, negate)
  -- function num : 0_8
  for i = idx, #str do
    if set[str:sub(i, i)] ~= negate then
      return i
    end
  end
  return #str + 1
end

local decode_error = function(str, idx, msg)
  -- function num : 0_9 , upvalues : _ENV
  local line_count = 1
  local col_count = 1
  for i = 1, idx - 1 do
    col_count = col_count + 1
    if str:sub(i, i) == "\n" then
      line_count = line_count + 1
      col_count = 1
    end
  end
  error((string.format)("%s at line %d col %d", msg, line_count, col_count))
end

local codepoint_to_utf8 = function(n)
  -- function num : 0_10 , upvalues : _ENV
  local f = math.floor
  if n <= 127 then
    return (string.char)(n)
  else
    if n <= 2047 then
      return (string.char)(f(n / 64) + 192, n % 64 + 128)
    else
      if n <= 65535 then
        return (string.char)(f(n / 4096) + 224, f(n % 4096 / 64) + 128, n % 64 + 128)
      else
        if n <= 1114111 then
          return (string.char)(f(n / 262144) + 240, f(n % 262144 / 4096) + 128, f(n % 4096 / 64) + 128, n % 64 + 128)
        end
      end
    end
  end
  error((string.format)("invalid unicode codepoint \'%x\'", n))
end

local parse_unicode_escape = function(s)
  -- function num : 0_11 , upvalues : _ENV, codepoint_to_utf8
  local n1 = tonumber(s:sub(3, 6), 16)
  local n2 = tonumber(s:sub(9, 12), 16)
  if n2 then
    return codepoint_to_utf8((n1 - 55296) * 1024 + (n2 - 56320) + 65536)
  else
    return codepoint_to_utf8(n1)
  end
end

local parse_string = function(str, i)
  -- function num : 0_12 , upvalues : decode_error, _ENV, escape_chars, parse_unicode_escape, escape_char_map_inv
  local has_unicode_escape = false
  local has_surrogate_escape = false
  local has_escape = false
  local last = nil
  for j = i + 1, #str do
    local x = str:byte(j)
    if x < 32 then
      decode_error(str, j, "control character in string")
    end
    if last == 92 then
      if x == 117 then
        local hex = str:sub(j + 1, j + 5)
        if not hex:find("%x%x%x%x") then
          decode_error(str, j, "invalid unicode escape in string")
        end
        if hex:find("^[dD][89aAbB]") then
          has_surrogate_escape = true
        else
          has_unicode_escape = true
        end
      else
        do
          do
            local c = (string.char)(x)
            if not escape_chars[c] then
              decode_error(str, j, "invalid escape char \'" .. c .. "\' in string")
            end
            has_escape = true
            last = nil
            if x == 34 then
              local s = str:sub(i + 1, j - 1)
              if has_surrogate_escape then
                s = s:gsub("\\u[dD][89aAbB]..\\u....", parse_unicode_escape)
              end
              if has_unicode_escape then
                s = s:gsub("\\u....", parse_unicode_escape)
              end
              if has_escape then
                s = s:gsub("\\.", escape_char_map_inv)
              end
              return s, j + 1
            else
              do
                do
                  last = x
                  -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  decode_error(str, i, "expected closing quote for string")
end

local parse_number = function(str, i)
  -- function num : 0_13 , upvalues : next_char, delim_chars, _ENV, decode_error
  local x = next_char(str, i, delim_chars)
  local s = str:sub(i, x - 1)
  local n = tonumber(s)
  if not n then
    decode_error(str, i, "invalid number \'" .. s .. "\'")
  end
  return n, x
end

local parse_literal = function(str, i)
  -- function num : 0_14 , upvalues : next_char, delim_chars, literals, decode_error, literal_map
  local x = next_char(str, i, delim_chars)
  local word = str:sub(i, x - 1)
  if not literals[word] then
    decode_error(str, i, "invalid literal \'" .. word .. "\'")
  end
  return literal_map[word], x
end

local parse_array = function(str, i)
  -- function num : 0_15 , upvalues : next_char, space_chars, parse, decode_error
  local res = {}
  local n = 1
  i = i + 1
  while 1 do
    local x = nil
    i = next_char(str, i, space_chars, true)
    if str:sub(i, i) == "]" then
      i = i + 1
      break
    end
    x = parse(str, i)
    res[n] = x
    n = n + 1
    -- DECOMPILER ERROR at PC33: Overwrote pending register: R1 in 'AssignReg'

    local chr = str:sub(i, i)
    -- DECOMPILER ERROR at PC38: Overwrote pending register: R1 in 'AssignReg'

    if chr ~= "]" and chr ~= "," then
      decode_error(str, i, "expected \']\' or \',\'")
    end
  end
  do
    return res, i
  end
end

local parse_object = function(str, i)
  -- function num : 0_16 , upvalues : next_char, space_chars, decode_error, parse
  local res = {}
  i = i + 1
  while 1 do
    local key, val = nil, nil
    i = next_char(str, i, space_chars, true)
    if str:sub(i, i) == "}" then
      i = i + 1
      break
    end
    if str:sub(i, i) ~= "\"" then
      decode_error(str, i, "expected string for key")
    end
    key = parse(str, i)
    -- DECOMPILER ERROR at PC41: Overwrote pending register: R1 in 'AssignReg'

    if str:sub(i, i) ~= ":" then
      decode_error(str, i, "expected \':\' after key")
    end
    -- DECOMPILER ERROR at PC59: Overwrote pending register: R1 in 'AssignReg'

    -- DECOMPILER ERROR at PC64: Overwrote pending register: R1 in 'AssignReg'

    val = parse(str, i)
    res[key] = val
    -- DECOMPILER ERROR at PC73: Overwrote pending register: R1 in 'AssignReg'

    local chr = str:sub(i, i)
    -- DECOMPILER ERROR at PC78: Overwrote pending register: R1 in 'AssignReg'

    if chr ~= "}" and chr ~= "," then
      decode_error(str, i, "expected \'}\' or \',\'")
    end
  end
  do
    return res, i
  end
end

local char_func_map = {["\""] = parse_string, ["0"] = parse_number, ["1"] = parse_number, ["2"] = parse_number, ["3"] = parse_number, ["4"] = parse_number, ["5"] = parse_number, ["6"] = parse_number, ["7"] = parse_number, ["8"] = parse_number, ["9"] = parse_number, ["-"] = parse_number, t = parse_literal, f = parse_literal, n = parse_literal, ["["] = parse_array, ["{"] = parse_object}
parse = function(str, idx)
  -- function num : 0_17 , upvalues : char_func_map, decode_error
  local chr = str:sub(idx, idx)
  local f = char_func_map[chr]
  if f then
    return f(str, idx)
  end
  decode_error(str, idx, "unexpected character \'" .. chr .. "\'")
end

json.decode = function(str)
  -- function num : 0_18 , upvalues : _ENV, parse, next_char, space_chars, decode_error
  if type(str) ~= "string" then
    error("expected argument of type string, got " .. type(str))
  end
  local res, idx = parse(str, next_char(str, 1, space_chars, true))
  idx = next_char(str, idx, space_chars, true)
  if idx <= #str then
    decode_error(str, idx, "trailing garbage")
  end
  return res
end

return json

