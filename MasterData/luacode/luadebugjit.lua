local sethook = debug.sethook
local debugger_stackInfo, coro_debugger
local debugger_require = require
local debugger_exeLuaString, loadstring_
if loadstring then
  loadstring_ = loadstring
else
  loadstring_ = load
end
local ZZBase64 = {}
local LuaDebugTool_
if LuaDebugTool then
  LuaDebugTool_ = LuaDebugTool
elseif CS and CS.LuaDebugTool then
  LuaDebugTool_ = CS.LuaDebugTool
end
local LuaDebugTool = LuaDebugTool_
local loadstring = loadstring_
local getinfo = debug.getinfo

local function createSocket()
  local base = _G
  local string = require("string")
  local math = require("math")
  local socket = require("socket.core")
  local _M = socket
  
  function _M.connect4(address, port, laddress, lport)
    return socket.connect(address, port, laddress, lport, "inet")
  end
  
  function _M.connect6(address, port, laddress, lport)
    return socket.connect(address, port, laddress, lport, "inet6")
  end
  
  if not _M.connect then
    function _M.connect(address, port, laddress, lport)
      local sock, err = socket.tcp()
      
      if not sock then
        return nil, err
      end
      if laddress then
        local res, err = sock:bind(laddress, lport, -1)
        if not res then
          return nil, err
        end
      end
      local res, err = sock:connect(address, port)
      if not res then
        return nil, err
      end
      return sock
    end
  end
  
  function _M.bind(host, port, backlog)
    if host == "*" then
      host = "0.0.0.0"
    end
    local addrinfo, err = socket.dns.getaddrinfo(host)
    if not addrinfo then
      return nil, err
    end
    local sock, res
    err = "no info on address"
    for i, alt in base.ipairs(addrinfo) do
      if alt.family == "inet" then
        sock, err = socket.tcp4()
      else
        sock, err = socket.tcp6()
      end
      if not sock then
        return nil, err
      end
      sock:setoption("reuseaddr", true)
      res, err = sock:bind(alt.addr, port)
      if not res then
        sock:close()
      else
        res, err = sock:listen(backlog)
        if not res then
          sock:close()
        else
          return sock
        end
      end
    end
    return nil, err
  end
  
  _M.try = _M.newtry()
  
  function _M.choose(table)
    return function(name, opt1, opt2)
      if base.type(name) ~= "string" then
        name, opt1, opt2 = "default", name, opt1
      end
      local f = table[name or "nil"]
      if not f then
        base.error("unknown key (" .. base.tostring(name) .. ")", 3)
      else
        return f(opt1, opt2)
      end
    end
  end
  
  local sourcet, sinkt = {}, {}
  _M.sourcet = sourcet
  _M.sinkt = sinkt
  _M.BLOCKSIZE = 2048
  sinkt["close-when-done"] = function(sock)
    return base.setmetatable({
      getfd = function()
        return sock:getfd()
      end,
      dirty = function()
        return sock:dirty()
      end
    }, {
      __call = function(self, chunk, err)
        if not chunk then
          sock:close()
          return 1
        else
          return sock:send(chunk)
        end
      end
    })
  end
  sinkt["keep-open"] = function(sock)
    return base.setmetatable({
      getfd = function()
        return sock:getfd()
      end,
      dirty = function()
        return sock:dirty()
      end
    }, {
      __call = function(self, chunk, err)
        if chunk then
          return sock:send(chunk)
        else
          return 1
        end
      end
    })
  end
  sinkt.default = sinkt["keep-open"]
  _M.sink = _M.choose(sinkt)
  sourcet["by-length"] = function(sock, length)
    return base.setmetatable({
      getfd = function()
        return sock:getfd()
      end,
      dirty = function()
        return sock:dirty()
      end
    }, {
      __call = function()
        if length <= 0 then
          return nil
        end
        local size = math.min(socket.BLOCKSIZE, length)
        local chunk, err = sock:receive(size)
        if err then
          return nil, err
        end
        length = length - string.len(chunk)
        return chunk
      end
    })
  end
  sourcet["until-closed"] = function(sock)
    local done
    return base.setmetatable({
      getfd = function()
        return sock:getfd()
      end,
      dirty = function()
        return sock:dirty()
      end
    }, {
      __call = function()
        if done then
          return nil
        end
        local chunk, err, partial = sock:receive(socket.BLOCKSIZE)
        if not err then
          return chunk
        elseif err == "closed" then
          sock:close()
          done = 1
          return partial
        else
          return nil, err
        end
      end
    })
  end
  sourcet.default = sourcet["until-closed"]
  _M.source = _M.choose(sourcet)
  return _M
end

local function createJson()
  local math = require("math")
  local string = require("string")
  local table = require("table")
  local object
  local json = {}
  local json_private = {}
  json.EMPTY_ARRAY = {}
  json.EMPTY_OBJECT = {}
  local decode_scanArray, decode_scanComment, decode_scanConstant, decode_scanNumber, decode_scanObject, decode_scanString, decode_scanWhitespace, encodeString, isArray, isEncodable
  
  function json.encode(v)
    if v == nil then
      return "null"
    end
    local vtype = type(v)
    if vtype == "string" then
      return "\"" .. json_private.encodeString(v) .. "\""
    end
    if vtype == "number" or vtype == "boolean" then
      return tostring(v)
    end
    if vtype == "table" then
      local rval = {}
      local bArray, maxCount = isArray(v)
      if bArray then
        for i = 1, maxCount do
          table.insert(rval, json.encode(v[i]))
        end
      else
        for i, j in pairs(v) do
          if isEncodable(i) and isEncodable(j) then
            table.insert(rval, "\"" .. json_private.encodeString(i) .. "\":" .. json.encode(j))
          end
        end
      end
      if bArray then
        return "[" .. table.concat(rval, ",") .. "]"
      else
        return "{" .. table.concat(rval, ",") .. "}"
      end
    end
    if vtype == "function" and v == json.null then
      return "null"
    end
    assert(false, "encode attempt to encode unsupported type " .. vtype .. ":" .. tostring(v))
  end
  
  function json.decode(s, startPos)
    startPos = startPos and startPos or 1
    startPos = decode_scanWhitespace(s, startPos)
    assert(startPos <= string.len(s), "Unterminated JSON encoded object found at position in [" .. s .. "]")
    local curChar = string.sub(s, startPos, startPos)
    if curChar == "{" then
      return decode_scanObject(s, startPos)
    end
    if curChar == "[" then
      return decode_scanArray(s, startPos)
    end
    if string.find("+-0123456789.e", curChar, 1, true) then
      return decode_scanNumber(s, startPos)
    end
    if curChar == "\"" or curChar == "'" then
      return decode_scanString(s, startPos)
    end
    if string.sub(s, startPos, startPos + 1) == "/*" then
      return json.decode(s, decode_scanComment(s, startPos))
    end
    return decode_scanConstant(s, startPos)
  end
  
  function json.null()
    return json.null
  end
  
  function decode_scanArray(s, startPos)
    local array = {}
    local stringLen = string.len(s)
    assert(string.sub(s, startPos, startPos) == "[", "decode_scanArray called but array does not start at position " .. startPos .. " in string:\n" .. s)
    startPos = startPos + 1
    repeat
      startPos = decode_scanWhitespace(s, startPos)
      assert(stringLen >= startPos, "JSON String ended unexpectedly scanning array.")
      local curChar = string.sub(s, startPos, startPos)
      if curChar == "]" then
        return array, startPos + 1
      end
      if curChar == "," then
        startPos = decode_scanWhitespace(s, startPos + 1)
      end
      assert(stringLen >= startPos, "JSON String ended unexpectedly scanning array.")
      object, startPos = json.decode(s, startPos)
      table.insert(array, object)
    until false
  end
  
  function decode_scanComment(s, startPos)
    assert(string.sub(s, startPos, startPos + 1) == "/*", "decode_scanComment called but comment does not start at position " .. startPos)
    local endPos = string.find(s, "*/", startPos + 2)
    assert(endPos ~= nil, "Unterminated comment in string at " .. startPos)
    return endPos + 2
  end
  
  function decode_scanConstant(s, startPos)
    local consts = {
      ["true"] = true,
      ["false"] = false,
      null = nil
    }
    local constNames = {
      "true",
      "false",
      "null"
    }
    for i, k in pairs(constNames) do
      if string.sub(s, startPos, startPos + string.len(k) - 1) == k then
        return consts[k], startPos + string.len(k)
      end
    end
    assert(nil, "Failed to scan constant from string " .. s .. " at starting position " .. startPos)
  end
  
  function decode_scanNumber(s, startPos)
    local endPos = startPos + 1
    local stringLen = string.len(s)
    local acceptableChars = "+-0123456789.e"
    while string.find(acceptableChars, string.sub(s, endPos, endPos), 1, true) and endPos <= stringLen do
      endPos = endPos + 1
    end
    local stringValue = "return " .. string.sub(s, startPos, endPos - 1)
    local stringEval = loadstring(stringValue)
    assert(stringEval, "Failed to scan number [ " .. stringValue .. "] in JSON string at position " .. startPos .. " : " .. endPos)
    return stringEval(), endPos
  end
  
  function decode_scanObject(s, startPos)
    local object = {}
    local stringLen = string.len(s)
    local key, value
    assert(string.sub(s, startPos, startPos) == "{", "decode_scanObject called but object does not start at position " .. startPos .. " in string:\n" .. s)
    startPos = startPos + 1
    repeat
      startPos = decode_scanWhitespace(s, startPos)
      assert(stringLen >= startPos, "JSON string ended unexpectedly while scanning object.")
      local curChar = string.sub(s, startPos, startPos)
      if curChar == "}" then
        return object, startPos + 1
      end
      if curChar == "," then
        startPos = decode_scanWhitespace(s, startPos + 1)
      end
      assert(stringLen >= startPos, "JSON string ended unexpectedly scanning object.")
      key, startPos = json.decode(s, startPos)
      assert(stringLen >= startPos, "JSON string ended unexpectedly searching for value of key " .. key)
      startPos = decode_scanWhitespace(s, startPos)
      assert(stringLen >= startPos, "JSON string ended unexpectedly searching for value of key " .. key)
      assert(string.sub(s, startPos, startPos) == ":", "JSON object key-value assignment mal-formed at " .. startPos)
      startPos = decode_scanWhitespace(s, startPos + 1)
      assert(stringLen >= startPos, "JSON string ended unexpectedly searching for value of key " .. key)
      value, startPos = json.decode(s, startPos)
      object[key] = value
    until false
  end
  
  local escapeSequences = {
    ["\\t"] = "\t",
    ["\\f"] = "\f",
    ["\\r"] = "\r",
    ["\\n"] = "\n",
    ["\\b"] = "\b"
  }
  setmetatable(escapeSequences, {
    __index = function(t, k)
      return string.sub(k, 2)
    end
  })
  
  function decode_scanString(s, startPos)
    assert(startPos, "decode_scanString(..) called without start position")
    local startChar = string.sub(s, startPos, startPos)
    assert(startChar == "\"" or startChar == "'", "decode_scanString called for a non-string")
    local t = {}
    local i, j = startPos, startPos
    while string.find(s, startChar, j + 1) ~= j + 1 do
      local oldj = j
      i, j = string.find(s, "\\.", j + 1)
      local x, y = string.find(s, startChar, oldj + 1)
      if not i or i > x then
        i, j = x, y - 1
      end
      table.insert(t, string.sub(s, oldj + 1, i - 1))
      if string.sub(s, i, j) == "\\u" then
        local a = string.sub(s, j + 1, j + 4)
        j = j + 4
        local n = tonumber(a, 16)
        assert(n, "String decoding failed: bad Unicode escape " .. a .. " at position " .. i .. " : " .. j)
        local x
        if n < 128 then
          x = string.char(n % 128)
        elseif n < 2048 then
          x = string.char(192 + math.floor(n / 64) % 32, 128 + n % 64)
        else
          x = string.char(224 + math.floor(n / 4096) % 16, 128 + math.floor(n / 64) % 64, 128 + n % 64)
        end
        table.insert(t, x)
      else
        table.insert(t, escapeSequences[string.sub(s, i, j)])
      end
    end
    table.insert(t, string.sub(j, j + 1))
    assert(string.find(s, startChar, j + 1), "String decoding failed: missing closing " .. startChar .. " at position " .. j .. "(for string at position " .. startPos .. ")")
    return table.concat(t, ""), j + 2
  end
  
  function decode_scanWhitespace(s, startPos)
    local whitespace = " \n\r\t"
    local stringLen = string.len(s)
    while string.find(whitespace, string.sub(s, startPos, startPos), 1, true) and startPos <= stringLen do
      startPos = startPos + 1
    end
    return startPos
  end
  
  local escapeList = {
    ["\""] = "\\\"",
    ["\\"] = "\\\\",
    ["/"] = "\\/",
    ["\b"] = "\\b",
    ["\f"] = "\\f",
    ["\n"] = "\\n",
    ["\r"] = "\\r",
    ["\t"] = "\\t"
  }
  
  function json_private.encodeString(s)
    local s = tostring(s)
    return s:gsub(".", function(c)
      return escapeList[c]
    end)
  end
  
  function isArray(t)
    if t == json.EMPTY_ARRAY then
      return true, 0
    end
    if t == json.EMPTY_OBJECT then
      return false
    end
    local maxIndex = 0
    for k, v in pairs(t) do
      if type(k) == "number" and math.floor(k) == k and 1 <= k then
        if not isEncodable(v) then
          return false
        end
        maxIndex = math.max(maxIndex, k)
      elseif k == "n" then
        if v ~= (t.n or #t) then
          return false
        end
      elseif isEncodable(v) then
        return false
      end
    end
    return true, maxIndex
  end
  
  function isEncodable(o)
    local t = type(o)
    return t == "string" or t == "boolean" or t == "number" or t == "nil" or t == "table" or t == "function" and o == json.null
  end
  
  return json
end

local debugger_print = print
local debug_server, breakInfoSocket
local json = createJson()
local LuaDebugger = {
  fileMaps = {},
  Run = true,
  StepIn = false,
  StepNext = false,
  StepOut = false,
  breakInfos = {},
  runTimeType = nil,
  isHook = true,
  pathCachePaths = {},
  isProntToConsole = 1,
  isDebugPrint = true,
  hookType = "lrc",
  stepNextFun = nil,
  DebugLuaFie = "",
  runLineCount = 0,
  splitFilePaths = {},
  version = "1.0.7"
}
local debug_hook
local _resume = coroutine.resume

function coroutine.resume(co, ...)
  if LuaDebugger.isHook and coroutine.status(co) ~= "dead" then
    debug.sethook(co, debug_hook, "lrc")
  end
  return _resume(co, ...)
end

LuaDebugger.event = {
  S2C_SetBreakPoints = 1,
  C2S_SetBreakPoints = 2,
  S2C_RUN = 3,
  C2S_HITBreakPoint = 4,
  S2C_ReqVar = 5,
  C2S_ReqVar = 6,
  S2C_NextRequest = 7,
  C2S_NextResponse = 8,
  C2S_NextResponseOver = 9,
  S2C_StepInRequest = 10,
  C2S_StepInResponse = 11,
  S2C_StepOutRequest = 12,
  C2S_StepOutResponse = 13,
  C2S_LuaPrint = 14,
  S2C_LoadLuaScript = 16,
  C2S_SetSocketName = 17,
  C2S_LoadLuaScript = 18,
  C2S_DebugXpCall = 20,
  S2C_DebugClose = 21
}

function print(...)
  if LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 3 then
    debugger_print(...)
  end
  if (LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 2) and debug_server then
    local arg = {
      ...
    }
    local str = ""
    if #arg == 0 then
      arg = {"nil"}
    end
    for k, v in pairs(arg) do
      str = str .. tostring(v) .. "\t"
    end
    local sendMsg = {
      event = LuaDebugger.event.C2S_LuaPrint,
      data = {
        msg = ZZBase64.encode(str),
        type = 1
      }
    }
    local sendStr = json.encode(sendMsg)
    debug_server:send(sendStr .. "__debugger_k0204__")
  end
end

function luaIdePrintWarn(...)
  if LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 3 then
    debugger_print(...)
  end
  if (LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 2) and debug_server then
    local arg = {
      ...
    }
    local str = ""
    if #arg == 0 then
      arg = {"nil"}
    end
    for k, v in pairs(arg) do
      str = str .. tostring(v) .. "\t"
    end
    local sendMsg = {
      event = LuaDebugger.event.C2S_LuaPrint,
      data = {
        msg = ZZBase64.encode(str),
        type = 2
      }
    }
    local sendStr = json.encode(sendMsg)
    debug_server:send(sendStr .. "__debugger_k0204__")
  end
end

function luaIdePrintErr(...)
  if LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 3 then
    debugger_print(...)
  end
  if (LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 2) and debug_server then
    local arg = {
      ...
    }
    local str = ""
    if #arg == 0 then
      arg = {"nil"}
    end
    for k, v in pairs(arg) do
      str = str .. tostring(v) .. "\t"
    end
    local sendMsg = {
      event = LuaDebugger.event.C2S_LuaPrint,
      data = {
        msg = ZZBase64.encode(str),
        type = 3
      }
    }
    local sendStr = json.encode(sendMsg)
    debug_server:send(sendStr .. "__debugger_k0204__")
  end
end

local function debugger_lastIndex(str, p)
  local startIndex = string.find(str, p, 1)
  while startIndex do
    local findstartIndex = string.find(str, p, startIndex + 1)
    if not findstartIndex then
      break
    end
    startIndex = findstartIndex
  end
  return startIndex
end

local function debugger_convertParentDir(dir)
  local index, endindex = string.find(dir, "/%.%./")
  if index then
    local file1 = string.sub(dir, 1, index - 1)
    local startIndex = debugger_lastIndex(file1, "/")
    file1 = string.sub(file1, 1, startIndex - 1)
    local file2 = string.sub(dir, endindex)
    dir = file1 .. file2
    dir = debugger_convertParentDir(dir)
    return dir
  else
    return dir
  end
end

local function debugger_getFilePathInfo(file)
  local fileName, dir
  file = file:gsub("\\", "/")
  file = file:gsub("//", "/")
  file = file:gsub("/./", "/")
  if file:find("@") == 1 then
    file = file:sub(2)
  end
  local findex = file:find("%./")
  if findex == 1 then
    file = file:sub(3)
  end
  file = debugger_convertParentDir(file)
  local fileLength = string.len(file)
  local suffixNames = {
    ".lua",
    ".txt.lua",
    ".txt",
    ".bytes"
  }
  table.sort(suffixNames, function(name1, name2)
    return string.len(name1) > string.len(name2)
  end)
  local suffixLengs = {}
  for i, suffixName in ipairs(suffixNames) do
    table.insert(suffixLengs, string.len(suffixName))
  end
  local fileLength = string.len(file)
  for i, suffix in ipairs(suffixNames) do
    local suffixName = string.sub(file, fileLength - suffixLengs[i] + 1)
    if suffixName == suffix then
      file = string.sub(file, 1, fileLength - suffixLengs[i])
      break
    end
  end
  local fileNameStartIndex = debugger_lastIndex(file, "/")
  if fileNameStartIndex then
    fileName = string.sub(file, fileNameStartIndex + 1)
    dir = string.sub(file, 1, fileNameStartIndex)
    file = dir .. fileName
  else
    fileNameStartIndex = debugger_lastIndex(file, "%.")
    if not fileNameStartIndex then
      fileName = file
      dir = ""
    else
      dir = string.sub(file, 1, fileNameStartIndex)
      dir = dir:gsub("%.", "/")
      fileName = string.sub(file, fileNameStartIndex + 1)
      file = dir .. fileName
    end
  end
  return file, dir, fileName
end

local function debugger_strSplit(input, delimiter)
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

local function debugger_strTrim(input)
  input = string.gsub(input, "^[ \t\n\r]+", "")
  return string.gsub(input, "[ \t\n\r]+$", "")
end

local function debugger_dump(value, desciption, nesting)
  if type(nesting) ~= "number" then
    nesting = 3
  end
  local lookupTable = {}
  local result = {}
  
  local function _v(v)
    if type(v) == "string" then
      v = "\"" .. v .. "\""
    end
    return tostring(v)
  end
  
  local traceback = debugger_strSplit(debug.traceback("", 2), "\n")
  print("dump from: " .. debugger_strTrim(traceback[3]))
  
  local function _dump(value, desciption, indent, nest, keylen)
    desciption = desciption or "<var>"
    local spc = ""
    if type(keylen) == "number" then
      spc = string.rep(" ", keylen - string.len(_v(desciption)))
    end
    if type(value) ~= "table" then
      result[#result + 1] = string.format("%s%s%s = %s", indent, _v(desciption), spc, _v(value))
    elseif lookupTable[value] then
      result[#result + 1] = string.format("%s%s%s = *REF*", indent, desciption, spc)
    else
      lookupTable[value] = true
      if nest > nesting then
        result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, desciption)
      else
        result[#result + 1] = string.format("%s%s = {", indent, _v(desciption))
        local indent2 = indent .. "    "
        local keys = {}
        local keylen = 0
        local values = {}
        for k, v in pairs(value) do
          keys[#keys + 1] = k
          local vk = _v(k)
          local vkl = string.len(vk)
          if keylen < vkl then
            keylen = vkl
          end
          values[k] = v
        end
        table.sort(keys, function(a, b)
          if type(a) == "number" and type(b) == "number" then
            return a < b
          else
            return tostring(a) < tostring(b)
          end
        end)
        for i, k in ipairs(keys) do
          _dump(values[k], k, indent2, nest + 1, keylen)
        end
        result[#result + 1] = string.format("%s}", indent)
      end
    end
  end
  
  _dump(value, desciption, "- ", 1)
  for i, line in ipairs(result) do
    print(line)
  end
end

local function debugger_setVarInfo(name, value)
  local vt = type(value)
  local valueStr = ""
  if vt ~= "table" then
    valueStr = tostring(value)
    valueStr = ZZBase64.encode(valueStr)
  elseif LuaDebugger.isFoxGloryProject then
    valueStr = ZZBase64.encode("table")
  else
    local status, msg = xpcall(function()
      valueStr = tostring(value)
      valueStr = ZZBase64.encode(valueStr)
    end, function(error)
      valueStr = ZZBase64.encode("table")
    end)
  end
  local valueInfo = {
    name = name,
    valueType = vt,
    valueStr = valueStr
  }
  return valueInfo
end

local function debugger_getvalue(f)
  local i = 1
  local locals = {}
  while true do
    local name, value = debug.getlocal(f, i)
    if not name then
      break
    end
    if name ~= "(*temporary)" then
      locals[name] = value
    end
    i = i + 1
  end
  local func = getinfo(f, "f").func
  i = 1
  local ups = {}
  while func do
    local name, value = debug.getupvalue(func, i)
    if not name then
      break
    end
    if name == "_ENV" then
      ups._ENV_ = value
    else
      ups[name] = value
    end
    i = i + 1
  end
  return {locals = locals, ups = ups}
end

function debugger_stackInfo(ignoreCount, event)
  local datas = {}
  local stack = {}
  local varInfos = {}
  local funcs = {}
  local index = 0
  for i = ignoreCount, 100 do
    local source = getinfo(i)
    local isadd = true
    if i == ignoreCount then
      local file = source.source
      if file:find(LuaDebugger.DebugLuaFie) then
        return
      end
      if file == "=[C]" then
        isadd = false
      end
    end
    if not source then
      break
    end
    if isadd then
      local fullName, dir, fileName = debugger_getFilePathInfo(source.source)
      local info = {
        src = fullName,
        scoreName = source.name,
        currentline = source.currentline,
        linedefined = source.linedefined,
        what = source.what,
        nameWhat = source.namewhat
      }
      index = i
      local vars = debugger_getvalue(i + 1)
      table.insert(stack, info)
      table.insert(varInfos, vars)
      table.insert(funcs, source.func)
    end
    if source.what == "main" then
      break
    end
  end
  local stackInfo = {
    stack = stack,
    vars = varInfos,
    funcs = funcs
  }
  local data = {
    stack = stackInfo.stack,
    vars = stackInfo.vars,
    funcs = stackInfo.funcs,
    event = event,
    funcsLength = #stackInfo.funcs
  }
  return data
end

local debugger_setBreak

local function debugger_receiveDebugBreakInfo()
  if not jit then
    if _VERSION then
      print("当前lua版本为: " .. _VERSION .. " 请使用 -----LuaDebug.lua----- 进行调试!")
    else
      print("当前为lua版本,请使用-----LuaDebug.lua-----进行调试!")
    end
  end
  if breakInfoSocket then
    local msg, status = breakInfoSocket:receive()
    if msg then
      local netData = json.decode(msg)
      if netData.event == LuaDebugger.event.S2C_SetBreakPoints then
        debugger_setBreak(netData.data)
      elseif netData.event == LuaDebugger.event.S2C_LoadLuaScript then
        debugger_exeLuaString(netData.data, false)
      end
    end
  end
end

local function splitFilePath(path)
  if LuaDebugger.splitFilePaths[path] then
    return LuaDebugger.splitFilePaths[path]
  end
  local pos, arr = 0, {}
  for st, sp in function()
    return string.find(path, "/", pos, true)
  end, nil, nil do
    local pathStr = string.sub(path, pos, st - 1)
    table.insert(arr, pathStr)
    pos = sp + 1
  end
  local pathStr = string.sub(path, pos)
  table.insert(arr, pathStr)
  LuaDebugger.splitFilePaths[path] = arr
  return arr
end

function debugger_setBreak(datas)
  local breakInfos = LuaDebugger.breakInfos
  for i, data in ipairs(datas) do
    data.fileName = string.lower(data.fileName)
    data.serverPath = string.lower(data.serverPath)
    local breakInfo = breakInfos[data.fileName]
    if not breakInfo then
      breakInfos[data.fileName] = {}
      breakInfo = breakInfos[data.fileName]
    end
    if not data.breakDatas or #data.breakDatas == 0 then
      breakInfo[data.serverPath] = nil
    else
      local fileBreakInfo = breakInfo[data.serverPath]
      if not fileBreakInfo then
        fileBreakInfo = {
          pathNames = splitFilePath(data.serverPath),
          hitCounts = {}
        }
        breakInfo[data.serverPath] = fileBreakInfo
      end
      local lineInfos = {}
      for li, breakData in ipairs(data.breakDatas) do
        lineInfos[breakData.line] = breakData
        if breakData.hitCondition and breakData.hitCondition ~= "" then
          breakData.hitCondition = tonumber(breakData.hitCondition)
        else
          breakData.hitCondition = 0
        end
        if not fileBreakInfo.hitCounts[breakData.line] then
          fileBreakInfo.hitCounts[breakData.line] = 0
        end
      end
      fileBreakInfo.lines = lineInfos
      for line, count in pairs(fileBreakInfo.hitCounts) do
        if not lineInfos[line] then
          fileBreakInfo.hitCounts[line] = nil
        end
      end
    end
    local count = 0
    for i, linesInfo in pairs(breakInfo) do
      count = count + 1
    end
    if count == 0 then
      breakInfos[data.fileName] = nil
    end
  end
  local isHook = false
  for k, v in pairs(breakInfos) do
    isHook = true
    break
  end
  if isHook then
    if not LuaDebugger.isHook then
      debug.sethook(debug_hook, "lrc")
    end
    LuaDebugger.isHook = true
  else
    if LuaDebugger.isHook then
      debug.sethook()
    end
    LuaDebugger.isHook = false
  end
end

local function debugger_checkFileIsBreak(fileName)
  return LuaDebugger.breakInfos[fileName]
end

local controller_host = "192.168.1.102"
local controller_port = 7003

local function debugger_sendMsg(serverSocket, eventName, data)
  local sendMsg = {event = eventName, data = data}
  local sendStr = json.encode(sendMsg)
  serverSocket:send(sendStr .. "__debugger_k0204__")
end

function debugger_conditionStr(condition, vars, callBack)
  local function loadScript()
    local currentTabble = {}
    
    local locals = vars[1].locals
    local ups = vars[1].ups
    if ups then
      for k, v in pairs(ups) do
        currentTabble[k] = v
      end
    end
    if locals then
      for k, v in pairs(locals) do
        currentTabble[k] = v
      end
    end
    setmetatable(currentTabble, {
      __index = _G
    })
    local fun = loadstring("return " .. condition)
    setfenv(fun, currentTabble)
    return fun()
  end
  
  local status, msg = xpcall(loadScript, function(error)
    print(error)
  end)
  if status and msg then
    callBack()
  end
end

function debugger_exeLuaString(data, isBreakPoint)
  local function loadScript()
    local luastr = data.luastr
    
    if isBreakPoint then
      local currentTabble = {
        _G = _G
      }
      local frameId = data.frameId
      frameId = frameId + 1
      local func = LuaDebugger.currentDebuggerData.funcs[frameId]
      local vars = LuaDebugger.currentDebuggerData.vars[frameId]
      local locals = vars.locals
      local ups = vars.ups
      for k, v in pairs(ups) do
        currentTabble[k] = v
      end
      for k, v in pairs(locals) do
        currentTabble[k] = v
      end
      setmetatable(currentTabble, {
        __index = _G
      })
      local fun = loadstring(luastr)
      setfenv(fun, currentTabble)
      fun()
    else
      local fun = loadstring(luastr)
      fun()
    end
  end
  
  local status, msg = xpcall(loadScript, function(error)
    print(error)
  end)
  if status then
    debugger_sendMsg(debug_server, LuaDebugger.event.C2S_LoadLuaScript, {
      msg = "执行代码成功"
    })
    if isBreakPoint then
      debugger_sendMsg(debug_server, LuaDebugger.event.C2S_HITBreakPoint, LuaDebugger.currentDebuggerData.stack)
    end
  else
    debugger_sendMsg(debug_server, LuaDebugger.event.C2S_LoadLuaScript, {
      msg = "加载代码失败"
    })
  end
end

local function getSource(source)
  source = string.lower(source)
  if LuaDebugger.pathCachePaths[source] then
    LuaDebugger.currentLineFile = LuaDebugger.pathCachePaths[source]
    return LuaDebugger.pathCachePaths[source]
  end
  local fullName, dir, fileName = debugger_getFilePathInfo(source)
  LuaDebugger.currentLineFile = fullName
  LuaDebugger.pathCachePaths[source] = fileName
  return fileName
end

local function debugger_GeVarInfoBytUserData(server, var)
  local fileds = LuaDebugTool.getUserDataInfo(var)
  local varInfos = {}
  if tolua and tolua.getpeer then
    local luavars = tolua.getpeer(var)
    if luavars then
      for k, v in pairs(luavars) do
        local vinfo = debugger_setVarInfo(k, v)
        table.insert(varInfos, vinfo)
      end
    end
  end
  for i = 1, fileds.Count do
    local filed = fileds[i - 1]
    local valueInfo = {
      name = filed.name,
      valueType = filed.valueType,
      valueStr = ZZBase64.encode(filed.valueStr),
      isValue = filed.isValue,
      csharp = true
    }
    table.insert(varInfos, valueInfo)
  end
  return varInfos
end

local function debugger_getValueByScript(value, script)
  local val
  local status, msg = xpcall(function()
    local fun = loadstring("return " .. script)
    setfenv(fun, value)
    val = fun()
  end, function(error)
    print(error, "====>")
    val = nil
  end)
  return val
end

local function debugger_getVarByKeys(value, keys, index)
  local str = ""
  for i = index, #keys do
    local key = keys[i]
    if key == "[metatable]" then
    elseif i == index then
      if string.find(key, "%.") then
        if str == "" then
          i = index + 1
          value = value[key]
        end
        if i >= #keys then
          return index, value
        end
        return debugger_getVarByKeys(value, keys, i)
      else
        str = key
      end
    elseif string.find(key, "%[") then
      str = str .. key
    elseif type(key) == "string" then
      str = str .. "[\"" .. key .. "\"]"
    else
      str = str .. "[" .. key .. "]"
    end
  end
  local v = debugger_getValueByScript(value, str)
  return #keys, v
end

local function debugger_getCSharpValue(value, searchIndex, keys)
  local key = keys[searchIndex]
  local val = LuaDebugTool.getCSharpValue(value, key)
  if val then
    if searchIndex == #keys then
      return #keys, val
    else
      local vindex, val1 = debugger_getCSharpValue(val, searchIndex + 1, keys)
      if not val1 then
        local tempKeys = {}
        for i = vindex, #keys do
          table.insert(tempKeys, keys[i])
        end
        local vindx, val1 = debugger_searchVarByKeys(value, searckKeys, 1)
        return vindx, val1
      else
        return vindex, val1
      end
    end
  else
    return searchIndex, val
  end
end

local function debugger_searchVarByKeys(value, keys, searckKeys)
  local index, val = debugger_getVarByKeys(value, searckKeys, 1)
  if not LuaDebugTool then
    return index, val
  end
  if val then
    if index == #keys then
      return index, val
    else
      local searchStr = ""
      local keysLength = #keys
      local searchIndex = index + 1
      local sindex, val = debugger_getCSharpValue(val, searchIndex, keys)
      return sindex, val
    end
  else
    local tempKeys = {}
    for i = 1, #searckKeys - 1 do
      table.insert(tempKeys, keys[i])
    end
    if #tempKeys == 0 then
      return #keys, nil
    end
    return debugger_searchVarByKeys(value, keys, tempKeys)
  end
end

local function debugger_getmetatable(value, metatable, vinfos, server, variablesReference, debugSpeedIndex, metatables)
  for i, mtable in ipairs(metatables) do
    if metatable == mtable then
      return vinfos
    end
  end
  table.insert(metatables, metatable)
  for k, v in pairs(metatable) do
    local val
    if type(k) == "string" then
      xpcall(function()
        val = value[k]
      end, function(error)
        val = nil
      end)
      if val == nil then
        xpcall(function()
          if string.find(k, "__") then
            val = v
          end
        end, function(error)
          val = nil
        end)
      end
    end
    if val then
      do
        local vinfo = debugger_setVarInfo(k, val)
        table.insert(vinfos, vinfo)
        if 10 < #vinfos then
          debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
            variablesReference = variablesReference,
            debugSpeedIndex = debugSpeedIndex,
            vars = vinfos,
            isComplete = 0
          })
          vinfos = {}
        end
      end
    end
  end
  local m = getmetatable(metatable)
  if m then
    return debugger_getmetatable(value, m, vinfos, server, variablesReference, debugSpeedIndex, metatables)
  else
    return vinfos
  end
end

local function debugger_sendTableField(luatable, vinfos, server, variablesReference, debugSpeedIndex, valueType)
  if valueType == "userdata" then
    if tolua and tolua.getpeer then
      luatable = tolua.getpeer(luatable)
    else
      return vinfos
    end
  end
  if luatable == nil then
    return vinfos
  end
  for k, v in pairs(luatable) do
    local vinfo = debugger_setVarInfo(k, v)
    table.insert(vinfos, vinfo)
    if 10 < #vinfos then
      debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
        variablesReference = variablesReference,
        debugSpeedIndex = debugSpeedIndex,
        vars = vinfos,
        isComplete = 0
      })
      vinfos = {}
    end
  end
  return vinfos
end

local function debugger_sendTableValues(value, server, variablesReference, debugSpeedIndex)
  local vinfos = {}
  local luatable = {}
  local valueType = type(value)
  local userDataInfos = {}
  local m
  if valueType == "userdata" then
    if tolua and tolua.getpeer then
      m = getmetatable(value)
      vinfos = debugger_sendTableField(value, vinfos, server, variablesReference, debugSpeedIndex, valueType)
    end
    if LuaDebugTool then
      local varInfos = debugger_GeVarInfoBytUserData(server, value, variablesReference, debugSpeedIndex)
      for i, v in ipairs(varInfos) do
        if v.valueType == "System.Byte[]" and value[v.name] and type(value[v.name]) == "string" then
          local valueInfo = {
            name = v.name,
            valueType = "string",
            valueStr = ZZBase64.encode(value[v.name])
          }
          table.insert(vinfos, valueInfo)
        else
          table.insert(vinfos, v)
        end
        if 10 < #vinfos then
          debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
            variablesReference = variablesReference,
            debugSpeedIndex = debugSpeedIndex,
            vars = vinfos,
            isComplete = 0
          })
          vinfos = {}
        end
      end
      m = getmetatable(value)
    end
  else
    m = getmetatable(value)
    vinfos = debugger_sendTableField(value, vinfos, server, variablesReference, debugSpeedIndex, valueType)
  end
  if m then
    vinfos = debugger_getmetatable(value, m, vinfos, server, variablesReference, debugSpeedIndex, {})
  end
  debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
    variablesReference = variablesReference,
    debugSpeedIndex = debugSpeedIndex,
    vars = vinfos,
    isComplete = 1
  })
end

local function debugger_getBreakVar(body, server)
  local variablesReference = body.variablesReference
  local debugSpeedIndex = body.debugSpeedIndex
  local vinfos = {}
  
  local function exe()
    local frameId = body.frameId
    local type_ = body.type
    local keys = body.keys
    local vars
    if type_ == 1 then
      vars = LuaDebugger.currentDebuggerData.vars[frameId + 1]
      vars = vars.locals
    elseif type_ == 2 then
      vars = LuaDebugger.currentDebuggerData.vars[frameId + 1]
      vars = vars.ups
    elseif type_ == 3 then
      vars = _G
    end
    if #keys == 0 then
      debugger_sendTableValues(vars, server, variablesReference, debugSpeedIndex)
      return
    end
    local index, value = debugger_searchVarByKeys(vars, keys, keys)
    if value then
      local valueType = type(value)
      if valueType == "table" or valueType == "userdata" then
        debugger_sendTableValues(value, server, variablesReference, debugSpeedIndex)
      else
        if valueType == "function" then
          value = tostring(value)
        end
        debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
          variablesReference = variablesReference,
          debugSpeedIndex = debugSpeedIndex,
          vars = ZZBase64.encode(value),
          isComplete = 1,
          varType = valueType
        })
      end
    else
      debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
        variablesReference = variablesReference,
        debugSpeedIndex = debugSpeedIndex,
        vars = {},
        isComplete = 1,
        varType = "nil"
      })
    end
  end
  
  xpcall(exe, function(error)
    debugger_sendMsg(server, LuaDebugger.event.C2S_ReqVar, {
      variablesReference = variablesReference,
      debugSpeedIndex = debugSpeedIndex,
      vars = {
        {
          name = "error",
          valueType = "string",
          valueStr = ZZBase64.encode("无法获取属性值:" .. error .. "->" .. debug.traceback("", 2)),
          isValue = false
        }
      },
      isComplete = 1
    })
  end)
end

local function ResetDebugInfo()
  LuaDebugger.Run = false
  LuaDebugger.StepIn = false
  LuaDebugger.StepNext = false
  LuaDebugger.StepOut = false
end

local function debugger_loop(server)
  server = debug_server
  local command
  local eval_env = {}
  local arg
  while true do
    local line, status = server:receive()
    if status == "closed" then
      debug.sethook()
      coroutine.yield()
    end
    if line then
      local netData = json.decode(line)
      local event = netData.event
      local body = netData.data
      if event == LuaDebugger.event.S2C_DebugClose then
        debug.sethook()
        coroutine.yield()
      elseif event == LuaDebugger.event.S2C_SetBreakPoints then
        local function setB()
          debugger_setBreak(body)
        end
        
        xpcall(setB, function(error)
          print(error)
        end)
      elseif event == LuaDebugger.event.S2C_RUN then
        LuaDebugger.runTimeType = body.runTimeType
        LuaDebugger.isProntToConsole = body.isProntToConsole
        LuaDebugger.isFoxGloryProject = body.isFoxGloryProject
        ResetDebugInfo()
        LuaDebugger.currentDebuggerData = nil
        LuaDebugger.Run = true
        LuaDebugger.tempRunFlag = true
        local data = coroutine.yield()
        LuaDebugger.currentDebuggerData = data
        debugger_sendMsg(server, data.event, {
          stack = data.stack
        })
      elseif event == LuaDebugger.event.S2C_ReqVar then
        debugger_getBreakVar(body, server)
      elseif event == LuaDebugger.event.S2C_NextRequest then
        ResetDebugInfo()
        LuaDebugger.StepNext = true
        local data = coroutine.yield()
        LuaDebugger.currentDebuggerData = data
        debugger_sendMsg(server, data.event, {
          stack = data.stack
        })
      elseif event == LuaDebugger.event.S2C_StepInRequest then
        ResetDebugInfo()
        LuaDebugger.StepIn = true
        local data = coroutine.yield()
        LuaDebugger.currentDebuggerData = data
        debugger_sendMsg(server, data.event, {
          stack = data.stack,
          eventType = data.eventType
        })
      elseif event == LuaDebugger.event.S2C_StepOutRequest then
        ResetDebugInfo()
        LuaDebugger.StepOut = true
        local data = coroutine.yield()
        LuaDebugger.currentDebuggerData = data
        debugger_sendMsg(server, data.event, {
          stack = data.stack,
          eventType = data.eventType
        })
      elseif event == LuaDebugger.event.S2C_LoadLuaScript then
        debugger_exeLuaString(body, true)
      end
    end
  end
end

coro_debugger = coroutine.create(debugger_loop)

function debug_hook(event, line)
  if not LuaDebugger.isHook then
    return
  end
  if LuaDebugger.Run and event == "line" then
    local isCheck = false
    for k, breakInfo in pairs(LuaDebugger.breakInfos) do
      for bk, linesInfo in pairs(breakInfo) do
        if linesInfo.lines and linesInfo.lines[line] then
          isCheck = true
          break
        end
      end
      if isCheck then
        break
      end
    end
    if not isCheck then
      return
    end
  end
  local file
  if event == "line" then
    local funs
    local funlength = 0
    if LuaDebugger.currentDebuggerData then
      funs = LuaDebugger.currentDebuggerData.funcs
      funlength = #funs
    end
    local stepInfo = getinfo(2)
    local tempFunc = stepInfo.func
    local source = stepInfo.source
    file = getSource(source)
    if source == "=[C]" or source:find(LuaDebugger.DebugLuaFie) then
      return
    end
    if 0 < funlength and funs[1] == tempFunc and LuaDebugger.currentLine ~= line then
      LuaDebugger.runLineCount = LuaDebugger.runLineCount + 1
    end
    local breakInfo = LuaDebugger.breakInfos[file]
    local breakData
    local ischeck = false
    if breakInfo then
      for k, lineInfo in pairs(breakInfo) do
        local lines = lineInfo.lines
        if lines and lines[line] then
          ischeck = true
          break
        end
      end
    end
    local isHit = false
    if ischeck then
      local info = stepInfo
      local source = string.lower(info.source)
      local fullName, dir, fileName = debugger_getFilePathInfo(source)
      local hitPathNames = splitFilePath(fullName)
      local hitCounts = {}
      local debugHitCounts
      for k, lineInfo in pairs(breakInfo) do
        local lines = lineInfo.lines
        local pathNames = lineInfo.pathNames
        debugHitCounts = lineInfo.hitCounts
        if lines and lines[line] then
          breakData = lines[line]
          hitCounts[k] = 0
          local hitPathNamesCount = #hitPathNames
          local pathNamesCount = #pathNames
          while pathNames[pathNamesCount] == hitPathNames[hitPathNamesCount] do
            hitCounts[k] = hitCounts[k] + 1
            pathNamesCount = pathNamesCount - 1
            hitPathNamesCount = hitPathNamesCount - 1
            if pathNamesCount <= 0 or hitPathNamesCount <= 0 then
              break
            end
          end
        else
          breakData = nil
        end
      end
      if breakData then
        local hitFieName = ""
        local maxCount = 0
        for k, v in pairs(hitCounts) do
          if v > maxCount then
            maxCount = v
            hitFieName = k
          end
        end
        if (#hitPathNames == 1 or 1 < #hitPathNames and 1 < maxCount) and hitFieName ~= "" then
          local hitCount = breakData.hitCondition
          local clientHitCount = debugHitCounts[breakData.line]
          clientHitCount = clientHitCount + 1
          debugHitCounts[breakData.line] = clientHitCount
          if funs and funs[1] == tempFunc and LuaDebugger.runLineCount == 0 then
            LuaDebugger.runLineCount = 0
          elseif LuaDebugger.tempRunFlag and LuaDebugger.currentLine == line then
            LuaDebugger.runLineCount = 0
            LuaDebugger.tempRunFlag = nil
          elseif hitCount <= clientHitCount then
            isHit = true
          end
        end
      end
    end
    if LuaDebugger.StepOut then
      if funlength == 1 then
        ResetDebugInfo()
        LuaDebugger.Run = true
        return
      elseif funs[2] == tempFunc then
        local data = debugger_stackInfo(3, LuaDebugger.event.C2S_StepInResponse)
        _resume(coro_debugger, data)
        return
      end
    end
    if LuaDebugger.StepIn then
      if funs[1] == tempFunc and LuaDebugger.runLineCount == 0 then
        return
      end
      local data = debugger_stackInfo(3, LuaDebugger.event.C2S_StepInResponse)
      _resume(coro_debugger, data)
      return
    end
    if LuaDebugger.StepNext then
      local isNext = false
      if funs then
        for i, f in ipairs(funs) do
          if tempFunc == f then
            if LuaDebugger.currentLine == line then
              return
            end
            isNext = true
            break
          end
        end
      else
        isNext = true
      end
      if isNext then
        local data = debugger_stackInfo(3, LuaDebugger.event.C2S_NextResponse)
        LuaDebugger.runLineCount = 0
        LuaDebugger.currentLine = line
        _resume(coro_debugger, data)
        return
      end
    end
    local sevent
    if isHit then
      LuaDebugger.runLineCount = 0
      LuaDebugger.currentLine = line
      sevent = LuaDebugger.event.C2S_HITBreakPoint
      local data = debugger_stackInfo(3, sevent)
      if breakData and breakData.condition then
        debugger_conditionStr(breakData.condition, data.vars, function()
          _resume(coro_debugger, data)
        end)
      else
        _resume(coro_debugger, data)
      end
    end
  end
end

local function debugger_xpcall()
  local data = debugger_stackInfo(4, LuaDebugger.event.C2S_HITBreakPoint)
  _resume(coro_debugger, data)
end

local function start()
  local socket = createSocket()
  print(controller_host)
  print(controller_port)
  local fullName, dirName, fileName = debugger_getFilePathInfo(getinfo(1).source)
  LuaDebugger.DebugLuaFie = fileName
  local server = socket.connect(controller_host, controller_port)
  debug_server = server
  if server then
    socket = createSocket()
    breakInfoSocket = socket.connect(controller_host, controller_port)
    if breakInfoSocket then
      breakInfoSocket:settimeout(0)
      debugger_sendMsg(breakInfoSocket, LuaDebugger.event.C2S_SetSocketName, {
        name = "breakPointSocket"
      })
      debugger_sendMsg(server, LuaDebugger.event.C2S_SetSocketName, {
        name = "mainSocket",
        version = LuaDebugger.version
      })
      xpcall(function()
        sethook(debug_hook, "lrc")
      end, function(error)
        print("error:", error)
      end)
      if not jit then
        if _VERSION then
          print("当前lua版本为: " .. _VERSION .. " 请使用LuaDebug 进行调试!")
        else
          print("当前为lua版本,请使用LuaDebug 进行调试!")
        end
      end
      _resume(coro_debugger, server)
    end
  end
end

function StartDebug(host, port)
  if not host then
    print("error host nil")
  end
  if not port then
    print("error prot nil")
  end
  if type(host) ~= "string" then
    print("error host not string")
  end
  if type(port) ~= "number" then
    print("error host not number")
  end
  controller_host = host
  controller_port = port
  xpcall(start, function(error)
    print(error)
  end)
  return debugger_receiveDebugBreakInfo, debugger_xpcall
end

local string = _ENV.string
ZZBase64.__code = {
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z",
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "+",
  "/"
}
ZZBase64.__decode = {}
for k, v in pairs(ZZBase64.__code) do
  ZZBase64.__decode[string.byte(v, 1)] = k - 1
end

function ZZBase64.encode(text)
  local len = string.len(text)
  local left = len % 3
  len = len - left
  local res = {}
  local index = 1
  for i = 1, len, 3 do
    local a = string.byte(text, i)
    local b = string.byte(text, i + 1)
    local c = string.byte(text, i + 2)
    local num = a * 65536 + b * 256 + c
    for j = 1, 4 do
      local tmp = math.floor(num / 2 ^ ((4 - j) * 6))
      local curPos = tmp % 64 + 1
      res[index] = ZZBase64.__code[curPos]
      index = index + 1
    end
  end
  if left == 1 then
    ZZBase64.__left1(res, index, text, len)
  elseif left == 2 then
    ZZBase64.__left2(res, index, text, len)
  end
  return table.concat(res)
end

function ZZBase64.__left2(res, index, text, len)
  local num1 = string.byte(text, len + 1)
  num1 = num1 * 1024
  local num2 = string.byte(text, len + 2)
  num2 = num2 * 4
  local num = num1 + num2
  local tmp1 = math.floor(num / 4096)
  local curPos = tmp1 % 64 + 1
  res[index] = ZZBase64.__code[curPos]
  local tmp2 = math.floor(num / 64)
  curPos = tmp2 % 64 + 1
  res[index + 1] = ZZBase64.__code[curPos]
  curPos = num % 64 + 1
  res[index + 2] = ZZBase64.__code[curPos]
  res[index + 3] = "="
end

function ZZBase64.__left1(res, index, text, len)
  local num = string.byte(text, len + 1)
  num = num * 16
  local tmp = math.floor(num / 64)
  local curPos = tmp % 64 + 1
  res[index] = ZZBase64.__code[curPos]
  curPos = num % 64 + 1
  res[index + 1] = ZZBase64.__code[curPos]
  res[index + 2] = "="
  res[index + 3] = "="
end

function ZZBase64.decode(text)
  local len = string.len(text)
  local left = 0
  if string.sub(text, len - 1) == "==" then
    left = 2
    len = len - 4
  elseif string.sub(text, len) == "=" then
    left = 1
    len = len - 4
  end
  local res = {}
  local index = 1
  local decode = ZZBase64.__decode
  for i = 1, len, 4 do
    local a = decode[string.byte(text, i)]
    local b = decode[string.byte(text, i + 1)]
    local c = decode[string.byte(text, i + 2)]
    local d = decode[string.byte(text, i + 3)]
    local num = a * 262144 + b * 4096 + c * 64 + d
    local e = string.char(num % 256)
    num = math.floor(num / 256)
    local f = string.char(num % 256)
    num = math.floor(num / 256)
    res[index] = string.char(num % 256)
    res[index + 1] = f
    res[index + 2] = e
    index = index + 3
  end
  if left == 1 then
    ZZBase64.__decodeLeft1(res, index, text, len)
  elseif left == 2 then
    ZZBase64.__decodeLeft2(res, index, text, len)
  end
  return table.concat(res)
end

function ZZBase64.__decodeLeft1(res, index, text, len)
  local decode = ZZBase64.__decode
  local a = decode[string.byte(text, len + 1)]
  local b = decode[string.byte(text, len + 2)]
  local c = decode[string.byte(text, len + 3)]
  local num = a * 4096 + b * 64 + c
  local num1 = math.floor(num / 1024) % 256
  local num2 = math.floor(num / 4) % 256
  res[index] = string.char(num1)
  res[index + 1] = string.char(num2)
end

function ZZBase64.__decodeLeft2(res, index, text, len)
  local decode = ZZBase64.__decode
  local a = decode[string.byte(text, len + 1)]
  local b = decode[string.byte(text, len + 2)]
  local num = a * 64 + b
  num = math.floor(num / 16)
  res[index] = string.char(num)
end

return StartDebug
