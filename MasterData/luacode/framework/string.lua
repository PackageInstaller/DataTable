string._htmlspecialchars_set = {}
string._htmlspecialchars_set["&"] = "&amp;"
string._htmlspecialchars_set["\""] = "&quot;"
string._htmlspecialchars_set["'"] = "&#039;"
string._htmlspecialchars_set["<"] = "&lt;"
string._htmlspecialchars_set[">"] = "&gt;"

function string.htmlspecialchars(input)
  for k, v in pairs(string._htmlspecialchars_set) do
    input = string.gsub(input, k, v)
  end
  return input
end

function string.restorehtmlspecialchars(input)
  for k, v in pairs(string._htmlspecialchars_set) do
    input = string.gsub(input, v, k)
  end
  return input
end

function string.nl2br(input)
  return string.gsub(input, "\n", "<br />")
end

function string.text2html(input)
  input = string.gsub(input, "\t", "    ")
  input = string.htmlspecialchars(input)
  input = string.gsub(input, " ", "&nbsp;")
  input = string.nl2br(input)
  return input
end

function string.split(input, delimiter)
  input = tostring(input)
  delimiter = tostring(delimiter)
  if delimiter == "" then
    return false
  end
  local pos, arr = 0, {}
  for st, sp in function()
    return string.find(input, delimiter, pos, true)
  end, nil, nil do
    table.insert(arr, string.sub(input, pos, st - 1))
    pos = sp + 1
  end
  table.insert(arr, string.sub(input, pos))
  return arr
end

function string.ltrim(input)
  return string.gsub(input, "^[ \t\n\r]+", "")
end

function string.rtrim(input)
  return string.gsub(input, "[ \t\n\r]+$", "")
end

function string.trim(input)
  input = string.gsub(input, "^[ \t\n\r]+", "")
  return string.gsub(input, "[ \t\n\r]+$", "")
end

function string.wtrim(input)
  return string.gsub(input, "[ \t\n\r]+", "")
end

function string.ucfirst(input)
  return string.upper(string.sub(input, 1, 1)) .. string.sub(input, 2)
end

local function urlencodechar(char)
  return "%" .. string.format("%02X", string.byte(char))
end

function string.urlencode(input)
  input = string.gsub(tostring(input), "\n", "\r\n")
  input = string.gsub(input, "([^%w%.%- ])", urlencodechar)
  return string.gsub(input, " ", "+")
end

function string.urldecode(input)
  input = string.gsub(input, "+", " ")
  input = string.gsub(input, "%%(%x%x)", function(h)
    return string.char(checknumber(h, 16))
  end)
  input = string.gsub(input, "\r\n", "\n")
  return input
end

function string.utf8len(input)
  local len = string.len(input)
  local left = len
  local cnt = 0
  local arr = {
    0,
    192,
    224,
    240,
    248,
    252
  }
  while left ~= 0 do
    local tmp = string.byte(input, -left)
    local i = #arr
    while arr[i] do
      if tmp >= arr[i] then
        left = left - i
        break
      end
      i = i - 1
    end
    cnt = cnt + 1
  end
  return cnt
end

function string.formatnumberthousands(num)
  local formatted = tostring(checknumber(num))
  local k
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
    if k == 0 then
      break
    end
  end
  return formatted
end

function string.startWith(text, pattern, index)
  local textFind = {
    string.find(text, pattern, index)
  }
  return textFind[1] == index, textFind
end
