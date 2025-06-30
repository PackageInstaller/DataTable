-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/string.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
-- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

string._htmlspecialchars_set = {}
-- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

;
(string._htmlspecialchars_set)["&"] = "&amp;"
-- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

;
(string._htmlspecialchars_set)["\""] = "&quot;"
-- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

;
(string._htmlspecialchars_set)["\'"] = "&#039;"
-- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

;
(string._htmlspecialchars_set)["<"] = "&lt;"
-- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

;
(string._htmlspecialchars_set)[">"] = "&gt;"
-- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

string.htmlspecialchars = function(input)
  -- function num : 0_0 , upvalues : _ENV
  for k,v in pairs(string._htmlspecialchars_set) do
    input = (string.gsub)(input, k, v)
  end
  return input
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

string.restorehtmlspecialchars = function(input)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs(string._htmlspecialchars_set) do
    input = (string.gsub)(input, v, k)
  end
  return input
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

string.nl2br = function(input)
  -- function num : 0_2 , upvalues : _ENV
  return (string.gsub)(input, "\n", "<br />")
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

string.text2html = function(input)
  -- function num : 0_3 , upvalues : _ENV
  input = (string.gsub)(input, "\t", "    ")
  input = (string.htmlspecialchars)(input)
  input = (string.gsub)(input, " ", "&nbsp;")
  input = (string.nl2br)(input)
  return input
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

string.split = function(input, delimiter)
  -- function num : 0_4 , upvalues : _ENV
  input = tostring(input)
  delimiter = tostring(delimiter)
  if delimiter == "" then
    return false
  end
  local pos, arr = 0, {}
  for st,sp in function()
    -- function num : 0_4_0 , upvalues : _ENV, input, delimiter, pos
    return (string.find)(input, delimiter, pos, true)
  end
 do
    (table.insert)(arr, (string.sub)(input, pos, st - 1))
    pos = sp + 1
  end
  ;
  (table.insert)(arr, (string.sub)(input, pos))
  return arr
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

string.ltrim = function(input)
  -- function num : 0_5 , upvalues : _ENV
  return (string.gsub)(input, "^[ \t\n\r]+", "")
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R0 in 'UnsetPending'

string.rtrim = function(input)
  -- function num : 0_6 , upvalues : _ENV
  return (string.gsub)(input, "[ \t\n\r]+$", "")
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

string.trim = function(input)
  -- function num : 0_7 , upvalues : _ENV
  input = (string.gsub)(input, "^[ \t\n\r]+", "")
  return (string.gsub)(input, "[ \t\n\r]+$", "")
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

string.wtrim = function(input)
  -- function num : 0_8 , upvalues : _ENV
  return (string.gsub)(input, "[ \t\n\r]+", "")
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

string.ucfirst = function(input)
  -- function num : 0_9 , upvalues : _ENV
  return (string.upper)((string.sub)(input, 1, 1)) .. (string.sub)(input, 2)
end

local urlencodechar = function(char)
  -- function num : 0_10 , upvalues : _ENV
  return "%" .. (string.format)("%02X", (string.byte)(char))
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

string.urlencode = function(input)
  -- function num : 0_11 , upvalues : _ENV, urlencodechar
  input = (string.gsub)(tostring(input), "\n", "\r\n")
  input = (string.gsub)(input, "([^%w%.%- ])", urlencodechar)
  return (string.gsub)(input, " ", "+")
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

string.urldecode = function(input)
  -- function num : 0_12 , upvalues : _ENV
  input = (string.gsub)(input, "+", " ")
  input = (string.gsub)(input, "%%(%x%x)", function(h)
    -- function num : 0_12_0 , upvalues : _ENV
    return (string.char)(checknumber(h, 16))
  end
)
  input = (string.gsub)(input, "\r\n", "\n")
  return input
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R1 in 'UnsetPending'

string.utf8len = function(input)
  -- function num : 0_13 , upvalues : _ENV
  local len = (string.len)(input)
  local left = len
  local cnt = 0
  local arr = {0, 192, 224, 240, 248, 252}
  while left ~= 0 do
    local tmp = (string.byte)(input, -left)
    local i = #arr
    while arr[i] do
      if arr[i] <= tmp then
        left = left - i
        break
      end
      i = i - 1
    end
    cnt = cnt + 1
  end
  do
    return cnt
  end
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R1 in 'UnsetPending'

string.formatnumberthousands = function(num)
  -- function num : 0_14 , upvalues : _ENV
  (tostring(checknumber(num)))
  local formatted = nil
  local k = nil
  while 1 do
    formatted = (string.gsub)(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
  end
  if k ~= 0 then
    return formatted
  end
end

-- DECOMPILER ERROR at PC63: Confused about usage of register: R1 in 'UnsetPending'

string.startWith = function(text, pattern, index)
  -- function num : 0_15 , upvalues : _ENV
  local textFind = {(string.find)(text, pattern, index)}
  do return textFind[1] == index, textFind end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end


