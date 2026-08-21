-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luadebug.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local debugger_reLoadFile, debugger_xpcall, debugger_stackInfo, coro_debugger = nil, nil, nil, nil
local debugger_require = require
local debugger_exeLuaString, checkSetVar, loadstring_, debugger_sendMsg = nil, nil, nil, nil
if loadstring then
  loadstring_ = loadstring
else
  loadstring_ = load
end
local setfenv = setfenv
if not setfenv then
  setfenv = function(fn, env)
  -- function num : 0_0 , upvalues : _ENV
  local i = 1
  while 1 do
    local name = (debug.getupvalue)(fn, i)
    if name == "_ENV" then
      (debug.upvaluejoin)(fn, i, function()
    -- function num : 0_0_0 , upvalues : env
    return env
  end
, 1)
      break
    else
    end
    if name then
      do
        i = i + 1
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  return fn
end

end
local ZZBase64 = {}
local LuaDebugTool_ = nil
if LuaDebugTool then
  LuaDebugTool_ = LuaDebugTool
else
  if CS and CS.LuaDebugTool then
    LuaDebugTool_ = CS.LuaDebugTool
  end
end
local LuaDebugTool = LuaDebugTool_
local loadstring = loadstring_
local getinfo = debug.getinfo
local createSocket = function()
  -- function num : 0_1 , upvalues : _ENV
  local base = _G
  local string = require("string")
  local math = require("math")
  local socket = require("socket.core")
  local _M = socket
  _M.connect4 = function(address, port, laddress, lport)
    -- function num : 0_1_0 , upvalues : socket
    return (socket.connect)(address, port, laddress, lport, "inet")
  end

  _M.connect6 = function(address, port, laddress, lport)
    -- function num : 0_1_1 , upvalues : socket
    return (socket.connect)(address, port, laddress, lport, "inet6")
  end

  if not _M.connect then
    _M.connect = function(address, port, laddress, lport)
    -- function num : 0_1_2 , upvalues : socket
    local sock, err = (socket.tcp)()
    if not sock then
      return nil, err
    end
    do
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

  end
  _M.bind = function(host, port, backlog)
    -- function num : 0_1_3 , upvalues : socket, base
    if host == "*" then
      host = "0.0.0.0"
    end
    local addrinfo, err = ((socket.dns).getaddrinfo)(host)
    if not addrinfo then
      return nil, err
    end
    local sock, res = nil, nil
    err = "no info on address"
    for i,alt in (base.ipairs)(addrinfo) do
      if alt.family == "inet" then
        sock = (socket.tcp4)()
      else
        -- DECOMPILER ERROR at PC28: Overwrote pending register: R4 in 'AssignReg'

        sock = (socket.tcp6)()
      end
      if not sock then
        return nil, err
      end
      sock:setoption("reuseaddr", true)
      -- DECOMPILER ERROR at PC43: Overwrote pending register: R4 in 'AssignReg'

      res = sock:bind(alt.addr, port)
      if not res then
        sock:close()
      else
        -- DECOMPILER ERROR at PC53: Overwrote pending register: R4 in 'AssignReg'

        res = sock:listen(backlog)
        if not res then
          sock:close()
        else
          return sock
        end
      end
    end
    return nil, err
  end

  _M.try = (_M.newtry)()
  _M.choose = function(table)
    -- function num : 0_1_4 , upvalues : base
    return function(name, opt1, opt2)
      -- function num : 0_1_4_0 , upvalues : base, table
      if (base.type)(name) ~= "string" then
        name = "default"
      end
      local f = table[name or "nil"]
      if not f then
        (base.error)("unknown key (" .. (base.tostring)(name) .. ")", 3)
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
    -- function num : 0_1_5 , upvalues : base
    return (base.setmetatable)({getfd = function()
      -- function num : 0_1_5_0 , upvalues : sock
      return sock:getfd()
    end
, dirty = function()
      -- function num : 0_1_5_1 , upvalues : sock
      return sock:dirty()
    end
}, {__call = function(self, chunk, err)
      -- function num : 0_1_5_2 , upvalues : sock
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
    -- function num : 0_1_6 , upvalues : base
    return (base.setmetatable)({getfd = function()
      -- function num : 0_1_6_0 , upvalues : sock
      return sock:getfd()
    end
, dirty = function()
      -- function num : 0_1_6_1 , upvalues : sock
      return sock:dirty()
    end
}, {__call = function(self, chunk, err)
      -- function num : 0_1_6_2 , upvalues : sock
      if chunk then
        return sock:send(chunk)
      else
        return 1
      end
    end
})
  end

  sinkt.default = sinkt["keep-open"]
  _M.sink = (_M.choose)(sinkt)
  sourcet["by-length"] = function(sock, length)
    -- function num : 0_1_7 , upvalues : base, math, socket, string
    return (base.setmetatable)({getfd = function()
      -- function num : 0_1_7_0 , upvalues : sock
      return sock:getfd()
    end
, dirty = function()
      -- function num : 0_1_7_1 , upvalues : sock
      return sock:dirty()
    end
}, {__call = function()
      -- function num : 0_1_7_2 , upvalues : length, math, socket, sock, string
      if length <= 0 then
        return nil
      end
      local size = (math.min)(socket.BLOCKSIZE, length)
      local chunk, err = sock:receive(size)
      if err then
        return nil, err
      end
      length = length - (string.len)(chunk)
      return chunk
    end
})
  end

  sourcet["until-closed"] = function(sock)
    -- function num : 0_1_8 , upvalues : base, socket
    local done = nil
    return (base.setmetatable)({getfd = function()
      -- function num : 0_1_8_0 , upvalues : sock
      return sock:getfd()
    end
, dirty = function()
      -- function num : 0_1_8_1 , upvalues : sock
      return sock:dirty()
    end
}, {__call = function()
      -- function num : 0_1_8_2 , upvalues : done, sock, socket
      if done then
        return nil
      end
      local chunk, err, partial = sock:receive(socket.BLOCKSIZE)
      if not err then
        return chunk
      else
        if err == "closed" then
          sock:close()
          done = 1
          return partial
        else
          return nil, err
        end
      end
    end
})
  end

  sourcet.default = sourcet["until-closed"]
  _M.source = (_M.choose)(sourcet)
  return _M
end

local createJson = function()
  -- function num : 0_2 , upvalues : _ENV, loadstring
  local math = require("math")
  local string = require("string")
  local table = (require("table"))
  -- DECOMPILER ERROR at PC9: Overwrote pending register: R3 in 'AssignReg'

  local object = .end
  local json = {}
  local json_private = {}
  json.EMPTY_ARRAY = {}
  json.EMPTY_OBJECT = {}
  local decode_scanArray, decode_scanComment, decode_scanConstant, decode_scanNumber, decode_scanObject, decode_scanString, decode_scanWhitespace, encodeString, isArray, isEncodable = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  json.encode = function(v)
    -- function num : 0_2_0 , upvalues : _ENV, json_private, isArray, table, json, isEncodable
    if v == nil then
      return "null"
    end
    local vtype = type(v)
    if vtype == "string" then
      return "\"" .. (json_private.encodeString)(v) .. "\""
    end
    if vtype == "number" or vtype == "boolean" then
      return tostring(v)
    end
    if vtype == "table" then
      local rval = {}
      local bArray, maxCount = isArray(v)
      if bArray then
        for i = 1, maxCount do
          (table.insert)(rval, (json.encode)(v[i]))
        end
      else
        do
          for i,j in pairs(v) do
            if isEncodable(i) and isEncodable(j) then
              (table.insert)(rval, "\"" .. (json_private.encodeString)(i) .. "\":" .. (json.encode)(j))
            end
          end
          do
            do
              if bArray then
                return "[" .. (table.concat)(rval, ",") .. "]"
              else
                return "{" .. (table.concat)(rval, ",") .. "}"
              end
              if vtype == "function" and v == json.null then
                return "null"
              end
              assert(false, "encode attempt to encode unsupported type " .. vtype .. ":" .. tostring(v))
            end
          end
        end
      end
    end
  end

  json.decode = function(s, startPos)
    -- function num : 0_2_1 , upvalues : decode_scanWhitespace, _ENV, string, decode_scanObject, decode_scanArray, decode_scanNumber, decode_scanString, json, decode_scanComment, decode_scanConstant
    if not startPos or not startPos then
      startPos = 1
    end
    startPos = decode_scanWhitespace(s, startPos)
    assert(startPos <= (string.len)(s), "Unterminated JSON encoded object found at position in [" .. s .. "]")
    local curChar = (string.sub)(s, startPos, startPos)
    if curChar == "{" then
      return decode_scanObject(s, startPos)
    end
    if curChar == "[" then
      return decode_scanArray(s, startPos)
    end
    if (string.find)("+-0123456789.e", curChar, 1, true) then
      return decode_scanNumber(s, startPos)
    end
    if curChar == "\"" or curChar == "\'" then
      return decode_scanString(s, startPos)
    end
    if (string.sub)(s, startPos, startPos + 1) == "/*" then
      return (json.decode)(s, decode_scanComment(s, startPos))
    end
    do return decode_scanConstant(s, startPos) end
    -- DECOMPILER ERROR: 7 unprocessed JMP targets
  end

  json.null = function()
    -- function num : 0_2_2 , upvalues : json
    return json.null
  end

  decode_scanArray = function(s, startPos)
    -- function num : 0_2_3 , upvalues : string, _ENV, decode_scanWhitespace, object, json, table
    local array = {}
    local stringLen = (string.len)(s)
    assert((string.sub)(s, startPos, startPos) == "[", "decode_scanArray called but array does not start at position " .. startPos .. " in string:\n" .. s)
    startPos = startPos + 1
    repeat
      startPos = decode_scanWhitespace(s, startPos)
      assert(startPos <= stringLen, "JSON String ended unexpectedly scanning array.")
      local curChar = (string.sub)(s, startPos, startPos)
      if curChar == "]" then
        return array, startPos + 1
      end
      if curChar == "," then
        startPos = decode_scanWhitespace(s, startPos + 1)
      end
      assert(startPos <= stringLen, "JSON String ended unexpectedly scanning array.")
      object = (json.decode)(s, startPos)
      ;
      (table.insert)(array, object)
    until false
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end

  decode_scanComment = function(s, startPos)
    -- function num : 0_2_4 , upvalues : _ENV, string
    assert((string.sub)(s, startPos, startPos + 1) == "/*", "decode_scanComment called but comment does not start at position " .. startPos)
    local endPos = (string.find)(s, "*/", startPos + 2)
    assert(endPos ~= nil, "Unterminated comment in string at " .. startPos)
    do return endPos + 2 end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end

  decode_scanConstant = function(s, startPos)
    -- function num : 0_2_5 , upvalues : _ENV, string
    local consts = {["true"] = true, ["false"] = false, null = nil}
    local constNames = {"true", "false", "null"}
    for i,k in pairs(constNames) do
      if (string.sub)(s, startPos, startPos + (string.len)(k) - 1) == k then
        return consts[k], startPos + (string.len)(k)
      end
    end
    assert(nil, "Failed to scan constant from string " .. s .. " at starting position " .. startPos)
  end

  decode_scanNumber = function(s, startPos)
    -- function num : 0_2_6 , upvalues : string, loadstring, _ENV
    local endPos = startPos + 1
    local stringLen = (string.len)(s)
    local acceptableChars = "+-0123456789.e"
    while (string.find)(acceptableChars, (string.sub)(s, endPos, endPos), 1, true) and endPos <= stringLen do
      endPos = endPos + 1
    end
    local stringValue = "return " .. (string.sub)(s, startPos, endPos - 1)
    local stringEval = loadstring(stringValue)
    assert(stringEval, "Failed to scan number [ " .. stringValue .. "] in JSON string at position " .. startPos .. " : " .. endPos)
    return stringEval(), endPos
  end

  decode_scanObject = function(s, startPos)
    -- function num : 0_2_7 , upvalues : string, _ENV, decode_scanWhitespace, json
    local object = {}
    local stringLen = ((string.len)(s))
    -- DECOMPILER ERROR at PC4: Overwrote pending register: R4 in 'AssignReg'

    local key, value = .end, nil
    assert((string.sub)(s, startPos, startPos) == "{", "decode_scanObject called but object does not start at position " .. startPos .. " in string:\n" .. s)
    startPos = startPos + 1
    repeat
      startPos = decode_scanWhitespace(s, startPos)
      assert(startPos <= stringLen, "JSON string ended unexpectedly while scanning object.")
      local curChar = (string.sub)(s, startPos, startPos)
      if curChar == "}" then
        return object, startPos + 1
      end
      if curChar == "," then
        startPos = decode_scanWhitespace(s, startPos + 1)
      end
      assert(startPos <= stringLen, "JSON string ended unexpectedly scanning object.")
      key = (json.decode)(s, startPos)
      assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)
      -- DECOMPILER ERROR at PC77: Overwrote pending register: R1 in 'AssignReg'

      assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)
      assert((string.sub)(s, startPos, startPos) == ":", "JSON object key-value assignment mal-formed at " .. startPos)
      -- DECOMPILER ERROR at PC105: Overwrote pending register: R1 in 'AssignReg'

      assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)
      -- DECOMPILER ERROR at PC119: Overwrote pending register: R1 in 'AssignReg'

      value = (json.decode)(s, startPos)
      object[key] = value
    until false
    -- DECOMPILER ERROR: 10 unprocessed JMP targets
  end

  local escapeSequences = {["\\t"] = "\t", ["\\f"] = "\f", ["\\r"] = "\r", ["\\n"] = "\n", ["\\b"] = "\b"}
  setmetatable(escapeSequences, {__index = function(t, k)
    -- function num : 0_2_8 , upvalues : string
    return (string.sub)(k, 2)
  end
})
  decode_scanString = function(s, startPos)
    -- function num : 0_2_9 , upvalues : _ENV, string, table, math, escapeSequences
    assert(startPos, "decode_scanString(..) called without start position")
    local startChar = (string.sub)(s, startPos, startPos)
    assert(startChar == "\"" or startChar == "\'", "decode_scanString called for a non-string")
    local t = {}
    local i, j = startPos, startPos
    while 1 do
      while 1 do
        if (string.find)(s, startChar, j + 1) ~= j + 1 then
          local oldj = j
          i = (string.find)(s, "\\.", j + 1)
          local x, y = (string.find)(s, startChar, oldj + 1)
          -- DECOMPILER ERROR at PC47: Overwrote pending register: R5 in 'AssignReg'

          if not i or x < i then
            i = x
          end
          ;
          (table.insert)(t, (string.sub)(s, oldj + 1, i - 1))
          if (string.sub)(s, i, j) == "\\u" then
            local a = (string.sub)(s, j + 1, j + 4)
            -- DECOMPILER ERROR at PC69: Overwrote pending register: R5 in 'AssignReg'

            local n = tonumber(a, 16)
            assert(n, "String decoding failed: bad Unicode escape " .. a .. " at position " .. i .. " : " .. j)
            do
              local x = nil
              if n < 128 then
                x = (string.char)(n % 128)
              elseif n < 2048 then
                x = (string.char)(192 + (math.floor)(n / 64) % 32, 128 + n % 64)
              else
                x = (string.char)(224 + (math.floor)(n / 4096) % 16, 128 + (math.floor)(n / 64) % 64, 128 + n % 64)
              end
              ;
              (table.insert)(t, x)
              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      ;
      (table.insert)(t, escapeSequences[(string.sub)(s, i, j)])
    end
    ;
    (table.insert)(t, (string.sub)(j, j + 1))
    assert((string.find)(s, startChar, j + 1), "String decoding failed: missing closing " .. startChar .. " at position " .. j .. "(for string at position " .. startPos .. ")")
    do return (table.concat)(t, ""), j + 2 end
    -- DECOMPILER ERROR: 9 unprocessed JMP targets
  end

  decode_scanWhitespace = function(s, startPos)
    -- function num : 0_2_10 , upvalues : string
    local whitespace = " \n\r\t"
    local stringLen = (string.len)(s)
    while (string.find)(whitespace, (string.sub)(s, startPos, startPos), 1, true) and startPos <= stringLen do
      startPos = startPos + 1
    end
    return startPos
  end

  local escapeList = {["\""] = "\\\"", ["\\"] = "\\\\", ["/"] = "\\/", ["\b"] = "\\b", ["\f"] = "\\f", ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t"}
  json_private.encodeString = function(s)
    -- function num : 0_2_11 , upvalues : _ENV, escapeList
    local s = tostring(s)
    return s:gsub(".", function(c)
      -- function num : 0_2_11_0 , upvalues : escapeList
      return escapeList[c]
    end
)
  end

  isArray = function(t)
    -- function num : 0_2_12 , upvalues : json, _ENV, math, isEncodable
    if t == json.EMPTY_ARRAY then
      return true, 0
    end
    if t == json.EMPTY_OBJECT then
      return false
    end
    local maxIndex = 0
    for k,v in pairs(t) do
      if type(k) == "number" and (math.floor)(k) == k and k >= 1 then
        if not isEncodable(v) then
          return false
        end
        maxIndex = (math.max)(maxIndex, k)
      else
        -- DECOMPILER ERROR at PC50: Unhandled construct in 'MakeBoolean' P1

        if k == "n" and (t.n or v ~= #t) then
          return false
        end
      end
      if isEncodable(v) then
        return false
      end
    end
    return true, maxIndex
  end

  isEncodable = function(o)
    -- function num : 0_2_13 , upvalues : _ENV, json
    local t = type(o)
    do return t == "string" or t == "boolean" or t == "number" or t == "nil" or t == "table" or (t == "function" and o == json.null) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  return json
end

local debugger_print = print
local debug_server, breakInfoSocket = nil, nil
local json = createJson()
local LuaDebugger = {
fileMaps = {}
, Run = true, StepIn = false, StepInLevel = 0, StepNext = false, StepNextLevel = 0, StepOut = false, 
breakInfos = {}
, runTimeType = nil, isHook = true, 
pathCachePaths = {}
, isProntToConsole = 1, isFoxGloryProject = false, isDebugPrint = true, hookType = "lrc", currentFileName = "", currentTempFunc = nil, 
splitFilePaths = {}
, DebugLuaFie = "", version = "0.9.3", serVarLevel = 4}
local debug_hook = nil
local _resume = coroutine.resume
-- DECOMPILER ERROR at PC71: Confused about usage of register: R24 in 'UnsetPending'

coroutine.resume = function(co, ...)
  -- function num : 0_3 , upvalues : LuaDebugger, _ENV, debug_hook, _resume
  if LuaDebugger.isHook and (coroutine.status)(co) ~= "dead" then
    (debug.sethook)(co, debug_hook, "lrc")
  end
  return _resume(co, ...)
end

local _wrap = coroutine.wrap
-- DECOMPILER ERROR at PC76: Confused about usage of register: R25 in 'UnsetPending'

coroutine.wrap = function(fun, dd)
  -- function num : 0_4 , upvalues : _wrap, _ENV, debug_hook
  local newFun = _wrap(function()
    -- function num : 0_4_0 , upvalues : _ENV, debug_hook, fun
    (debug.sethook)(debug_hook, "lrc")
    return fun()
  end
)
  return newFun
end

LuaDebugger.event = {S2C_SetBreakPoints = 1, C2S_SetBreakPoints = 2, S2C_RUN = 3, C2S_HITBreakPoint = 4, S2C_ReqVar = 5, C2S_ReqVar = 6, S2C_NextRequest = 7, C2S_NextResponse = 8, C2S_NextResponseOver = 9, S2C_StepInRequest = 10, C2S_StepInResponse = 11, S2C_StepOutRequest = 12, C2S_StepOutResponse = 13, C2S_LuaPrint = 14, S2C_LoadLuaScript = 16, C2S_SetSocketName = 17, C2S_LoadLuaScript = 18, C2S_DebugXpCall = 20, S2C_DebugClose = 21, S2C_SerVar = 24, C2S_SerVar = 25, S2C_ReLoadFile = 26, C2S_ReLoadFile = 27}
print = function(...)
  -- function num : 0_5 , upvalues : LuaDebugger, debugger_print, debug_server, _ENV, ZZBase64, json
  if LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 3 then
    debugger_print(...)
  end
  if (LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 2) and debug_server then
    local arg = {...}
    local str = ""
    if #arg == 0 then
      arg = {"nil"}
    end
    for k,v in pairs(arg) do
      str = str .. tostring(v) .. "\t"
    end
    local sendMsg = {event = (LuaDebugger.event).C2S_LuaPrint, 
data = {msg = (ZZBase64.encode)(str), type = 1}
}
    local sendStr = (json.encode)(sendMsg)
    debug_server:send(sendStr .. "__debugger_k0204__")
  end
end

luaIdePrintWarn = function(...)
  -- function num : 0_6 , upvalues : LuaDebugger, debugger_print, debug_server, _ENV, ZZBase64, json
  if LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 3 then
    debugger_print(...)
  end
  if (LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 2) and debug_server then
    local arg = {...}
    local str = ""
    if #arg == 0 then
      arg = {"nil"}
    end
    for k,v in pairs(arg) do
      str = str .. tostring(v) .. "\t"
    end
    local sendMsg = {event = (LuaDebugger.event).C2S_LuaPrint, 
data = {msg = (ZZBase64.encode)(str), type = 2}
}
    local sendStr = (json.encode)(sendMsg)
    debug_server:send(sendStr .. "__debugger_k0204__")
  end
end

luaIdePrintErr = function(...)
  -- function num : 0_7 , upvalues : LuaDebugger, debugger_print, debug_server, _ENV, ZZBase64, json
  if LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 3 then
    debugger_print(...)
  end
  if (LuaDebugger.isProntToConsole == 1 or LuaDebugger.isProntToConsole == 2) and debug_server then
    local arg = {...}
    local str = ""
    if #arg == 0 then
      arg = {"nil"}
    end
    for k,v in pairs(arg) do
      str = str .. tostring(v) .. "\t"
    end
    local sendMsg = {event = (LuaDebugger.event).C2S_LuaPrint, 
data = {msg = (ZZBase64.encode)(str), type = 3}
}
    local sendStr = (json.encode)(sendMsg)
    debug_server:send(sendStr .. "__debugger_k0204__")
  end
end

local debugger_lastIndex = function(str, p)
  -- function num : 0_8 , upvalues : _ENV
  local startIndex = (string.find)(str, p, 1)
  while 1 do
    if startIndex then
      local findstartIndex = (string.find)(str, p, startIndex + 1)
      if findstartIndex then
        do
          startIndex = findstartIndex
          -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC17: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return startIndex
end

local debugger_convertParentDir = function(dir)
  -- function num : 0_9 , upvalues : _ENV, debugger_lastIndex, debugger_convertParentDir
  local index, endindex = (string.find)(dir, "/%.%./")
  if index then
    local file1 = (string.sub)(dir, 1, index - 1)
    local startIndex = debugger_lastIndex(file1, "/")
    file1 = (string.sub)(file1, 1, startIndex - 1)
    local file2 = (string.sub)(dir, endindex)
    dir = file1 .. file2
    dir = debugger_convertParentDir(dir)
    return dir
  else
    do
      do return dir end
    end
  end
end

local debugger_getFilePathInfo = function(file)
  -- function num : 0_10 , upvalues : debugger_convertParentDir, _ENV, debugger_lastIndex
  local fileName, dir = nil, nil
  file = file:gsub("/.\\", "/")
  file = file:gsub("\\", "/")
  file = file:gsub("//", "/")
  if file:find("@") == 1 then
    file = file:sub(2)
  end
  local findex = file:find("%./")
  if findex == 1 then
    file = file:sub(3)
  end
  file = debugger_convertParentDir(file)
  local fileLength = (string.len)(file)
  local suffixNames = {".lua", ".lua.txt", ".txt", ".bytes"}
  ;
  (table.sort)(suffixNames, function(name1, name2)
    -- function num : 0_10_0 , upvalues : _ENV
    do return (string.len)(name2) < (string.len)(name1) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local suffixLengs = {}
  for i,suffixName in ipairs(suffixNames) do
    (table.insert)(suffixLengs, (string.len)(suffixName))
  end
  local fileLength = (string.len)(file)
  for i,suffix in ipairs(suffixNames) do
    local suffixName = (string.sub)(file, fileLength - suffixLengs[i] + 1)
    if suffixName == suffix then
      file = (string.sub)(file, 1, fileLength - suffixLengs[i])
      break
    end
  end
  do
    local fileNameStartIndex = debugger_lastIndex(file, "/")
    if fileNameStartIndex then
      fileName = (string.sub)(file, fileNameStartIndex + 1)
      dir = (string.sub)(file, 1, fileNameStartIndex)
      file = dir .. fileName
    else
      fileNameStartIndex = debugger_lastIndex(file, "%.")
      if not fileNameStartIndex then
        fileName = file
        dir = ""
      else
        dir = (string.sub)(file, 1, fileNameStartIndex)
        dir = dir:gsub("%.", "/")
        fileName = (string.sub)(file, fileNameStartIndex + 1)
        file = dir .. fileName
      end
    end
    return file, dir, fileName
  end
end

local debugger_strSplit = function(input, delimiter)
  -- function num : 0_11 , upvalues : _ENV
  input = tostring(input)
  delimiter = tostring(delimiter)
  if delimiter == "" then
    return false
  end
  local pos, arr = 0, {}
  for st,sp in function()
    -- function num : 0_11_0 , upvalues : _ENV, input, delimiter, pos
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

local debugger_strTrim = function(input)
  -- function num : 0_12 , upvalues : _ENV
  input = (string.gsub)(input, "^[ \t\n\r]+", "")
  return (string.gsub)(input, "[ \t\n\r]+$", "")
end

local debugger_dump = function(value, desciption, nesting)
  -- function num : 0_13 , upvalues : _ENV, debugger_strSplit, debugger_strTrim
  if type(nesting) ~= "number" then
    nesting = 3
  end
  local lookupTable = {}
  local result = {}
  local _v = function(v)
    -- function num : 0_13_0 , upvalues : _ENV
    if type(v) == "string" then
      v = "\"" .. v .. "\""
    end
    return tostring(v)
  end

  local traceback = debugger_strSplit((debug.traceback)("", 2), "\n")
  print("dump from: " .. debugger_strTrim(traceback[3]))
  local _dump = function(value, desciption, indent, nest, keylen)
    -- function num : 0_13_1 , upvalues : _ENV, _v, result, lookupTable, nesting, _dump
    if not desciption then
      desciption = "<var>"
    end
    local spc = ""
    if type(keylen) == "number" then
      spc = (string.rep)(" ", keylen - (string.len)(_v(desciption)))
    end
    if type(value) ~= "table" then
      result[#result + 1] = (string.format)("%s%s%s = %s", indent, _v(desciption), spc, _v(value))
    else
      if lookupTable[value] then
        result[#result + 1] = (string.format)("%s%s%s = *REF*", indent, desciption, spc)
      else
        lookupTable[value] = true
        if nesting < nest then
          result[#result + 1] = (string.format)("%s%s = *MAX NESTING*", indent, desciption)
        else
          result[#result + 1] = (string.format)("%s%s = {", indent, _v(desciption))
          local indent2 = indent .. "    "
          local keys = {}
          local keylen = 0
          local values = {}
          for k,v in pairs(value) do
            keys[#keys + 1] = k
            local vk = _v(R16_PC100)
            R16_PC100 = string
            R16_PC100 = R16_PC100.len
            R16_PC100 = R16_PC100(vk)
            local vkl = nil
            if keylen < vkl then
              keylen = vkl
            end
            values[k] = v
          end
          ;
          (table.sort)(keys, function(a, b)
      -- function num : 0_13_1_0 , upvalues : _ENV
      if a >= b then
        do return type(a) ~= "number" or type(b) ~= "number" end
        do return tostring(a) < tostring(b) end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
)
          for i,k in ipairs(keys) do
            _dump(values[k], k, indent2, nest + 1, keylen)
          end
          result[#result + 1] = (string.format)("%s}", indent)
        end
      end
    end
  end

  _dump(value, desciption, "- ", 1)
  for i,line in ipairs(result) do
    print(line)
  end
end

local debugger_valueToString = function(v)
  -- function num : 0_14 , upvalues : _ENV, LuaDebugger
  (type(v))
  local vtype = nil
  local vstr = nil
  if vtype == "userdata" then
    if LuaDebugger.isFoxGloryProject then
      return "userdata", vtype
    else
      return tostring(v), vtype
    end
  else
    if vtype == "table" or vtype == "function" or vtype == "boolean" then
      local value = vtype
      do
        xpcall(function()
    -- function num : 0_14_0 , upvalues : value, _ENV, v
    value = tostring(v)
  end
, function()
    -- function num : 0_14_1 , upvalues : value, vtype
    value = vtype
  end
)
        return value, vtype
      end
    else
      do
        if vtype == "number" or vtype == "string" then
          return v, vtype
        else
          return tostring(v), vtype
        end
      end
    end
  end
end

local debugger_setVarInfo = function(name, value)
  -- function num : 0_15 , upvalues : debugger_valueToString, ZZBase64
  local valueStr, valueType = debugger_valueToString(value)
  local nameStr, nameType = debugger_valueToString(name)
  if valueStr == nil then
    valueStr = valueType
  end
  local valueInfo = {name = nameStr, valueType = valueType, valueStr = (ZZBase64.encode)(valueStr)}
  return valueInfo
end

local debugger_getvalue = function(f)
  -- function num : 0_16 , upvalues : _ENV, getinfo
  local i = 1
  local locals = {}
  while 1 do
    local name, value = (debug.getlocal)(f, i)
    if name then
      do
        if name ~= "(*temporary)" then
          locals[name] = value
        end
        i = i + 1
        -- DECOMPILER ERROR at PC13: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC13: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local func = (getinfo(f, "f")).func
  i = 1
  local ups = {}
  while 1 do
    if func then
      local name, value = (debug.getupvalue)(func, i)
      if name then
        do
          if name == "_ENV" then
            ups._ENV_ = value
          else
            ups[name] = value
          end
          i = i + 1
          -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return {locals = locals, ups = ups}
end

debugger_stackInfo = function(ignoreCount, event)
  -- function num : 0_17 , upvalues : getinfo, LuaDebugger, debugger_getFilePathInfo, debugger_getvalue, _ENV
  local datas = {}
  local stack = {}
  local varInfos = {}
  local funcs = {}
  local index = 0
  for i = ignoreCount, 100 do
    local source = getinfo(i)
    local isadd = true
    do
      if i == ignoreCount then
        local file = source.source
        if file:find(LuaDebugger.DebugLuaFie) then
          return 
        end
        if file == "=[C]" then
          isadd = false
        end
      end
      if source then
        if isadd then
          local fullName, dir, fileName = debugger_getFilePathInfo(source.source)
          local info = {src = fullName, scoreName = source.name, currentline = source.currentline, linedefined = source.linedefined, what = source.what, nameWhat = source.namewhat}
          index = i
          local vars = debugger_getvalue(i + 1)
          ;
          (table.insert)(stack, info)
          ;
          (table.insert)(varInfos, vars)
          ;
          (table.insert)(funcs, source.func)
        end
        do
          -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  if source.what ~= "main" then
    local stackInfo = {stack = stack, vars = varInfos, funcs = funcs}
    local data = {stack = stackInfo.stack, vars = stackInfo.vars, funcs = stackInfo.funcs, event = event, funcsLength = #stackInfo.funcs, upFunc = (getinfo(ignoreCount - 3, "f")).func}
    LuaDebugger.currentTempFunc = (data.funcs)[1]
    return data
  end
end

local debugger_setBreak = nil
local debugger_receiveDebugBreakInfo = function()
  -- function num : 0_18 , upvalues : _ENV, LuaDebugger, breakInfoSocket, json, debugger_setBreak, debugger_exeLuaString, debugger_sendMsg, debugger_reLoadFile
  do
    if jit and LuaDebugger.debugLuaType ~= "jit" then
      local msg = "当前luajit版本为: " .. jit.version .. " 请使用LuaDebugjit 进行调试!"
      print(msg)
    end
    if breakInfoSocket then
      local msg, status = breakInfoSocket:receive()
      if LuaDebugger.isLaunch and status == "closed" then
        (os.exit)()
      end
      if msg then
        local netData = (json.decode)(msg)
        if netData.event == (LuaDebugger.event).S2C_SetBreakPoints then
          debugger_setBreak(netData.data)
        else
          if netData.event == (LuaDebugger.event).S2C_LoadLuaScript then
            LuaDebugger.loadScriptBody = netData.data
            debugger_exeLuaString()
            debugger_sendMsg(breakInfoSocket, (LuaDebugger.event).C2S_LoadLuaScript, LuaDebugger.loadScriptBody)
          else
            if netData.event == (LuaDebugger.event).S2C_ReLoadFile then
              LuaDebugger.reLoadFileBody = netData.data
              LuaDebugger.isReLoadFile = false
              -- DECOMPILER ERROR at PC70: Confused about usage of register: R3 in 'UnsetPending'

              ;
              (LuaDebugger.reLoadFileBody).isReLoad = debugger_reLoadFile(LuaDebugger.reLoadFileBody)
              print("重载结果:", (LuaDebugger.reLoadFileBody).isReLoad)
              -- DECOMPILER ERROR at PC77: Confused about usage of register: R3 in 'UnsetPending'

              ;
              (LuaDebugger.reLoadFileBody).script = nil
              debugger_sendMsg(breakInfoSocket, (LuaDebugger.event).C2S_ReLoadFile, {stack = LuaDebugger.reLoadFileBody})
            end
          end
        end
      end
    end
  end
end

local splitFilePath = function(path)
  -- function num : 0_19 , upvalues : LuaDebugger, _ENV
  if (LuaDebugger.splitFilePaths)[path] then
    return (LuaDebugger.splitFilePaths)[path]
  end
  local pos, arr = 0, {}
  for st,sp in function()
    -- function num : 0_19_0 , upvalues : _ENV, path, pos
    return (string.find)(path, "/", pos, true)
  end
 do
    local pathStr = (string.sub)(path, pos, st - 1)
    ;
    (table.insert)(arr, pathStr)
    pos = sp + 1
  end
  local pathStr = (string.sub)(path, pos)
  ;
  (table.insert)(arr, pathStr)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (LuaDebugger.splitFilePaths)[path] = arr
  return arr
end

debugger_setBreak = function(datas)
  -- function num : 0_20 , upvalues : LuaDebugger, _ENV, splitFilePath, debug_hook
  local breakInfos = LuaDebugger.breakInfos
  for i,data in ipairs(datas) do
    data.fileName = (string.lower)(data.fileName)
    data.serverPath = (string.lower)(data.serverPath)
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
        fileBreakInfo = {pathNames = splitFilePath(data.serverPath), 
hitCounts = {}
}
        breakInfo[data.serverPath] = fileBreakInfo
      end
      local lineInfos = {}
      for li,breakData in ipairs(data.breakDatas) do
        lineInfos[breakData.line] = breakData
        if breakData.hitCondition and breakData.hitCondition ~= "" then
          breakData.hitCondition = tonumber(breakData.hitCondition)
        else
          breakData.hitCondition = 0
        end
        -- DECOMPILER ERROR at PC74: Confused about usage of register: R15 in 'UnsetPending'

        if not (fileBreakInfo.hitCounts)[breakData.line] then
          (fileBreakInfo.hitCounts)[breakData.line] = 0
        end
      end
      fileBreakInfo.lines = lineInfos
      for line,count in pairs(fileBreakInfo.hitCounts) do
        -- DECOMPILER ERROR at PC86: Confused about usage of register: R15 in 'UnsetPending'

        if not lineInfos[line] then
          (fileBreakInfo.hitCounts)[line] = nil
        end
      end
    end
    do
      do
        local count = 0
        for i,linesInfo in pairs(breakInfo) do
          count = count + 1
        end
        if count == 0 then
          breakInfos[data.fileName] = nil
        end
        -- DECOMPILER ERROR at PC101: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  local isHook = false
  for k,v in pairs(breakInfos) do
    isHook = true
    do break end
  end
  do
    if isHook then
      if not LuaDebugger.isHook then
        (debug.sethook)(debug_hook, "lrc")
      end
      LuaDebugger.isHook = true
    else
      if LuaDebugger.isHook then
        (debug.sethook)()
      end
      LuaDebugger.isHook = false
    end
  end
end

local debugger_checkFileIsBreak = function(fileName)
  -- function num : 0_21 , upvalues : LuaDebugger
  return (LuaDebugger.breakInfos)[fileName]
end

local controller_host = "192.168.1.102"
local controller_port = 7003
debugger_sendMsg = function(serverSocket, eventName, data)
  -- function num : 0_22 , upvalues : json
  local sendMsg = {event = eventName, data = data}
  local sendStr = (json.encode)(sendMsg)
  serverSocket:send(sendStr .. "__debugger_k0204__")
end

debugger_conditionStr = function(condition, vars, callBack)
  -- function num : 0_23 , upvalues : _ENV, loadstring, setfenv
  local loadScript = function()
    -- function num : 0_23_0 , upvalues : vars, _ENV, loadstring, condition, setfenv
    local currentTabble = {}
    local locals = (vars[1]).locals
    local ups = (vars[1]).ups
    if ups then
      for k,v in pairs(ups) do
        currentTabble[k] = v
      end
    end
    do
      if locals then
        for k,v in pairs(locals) do
          currentTabble[k] = v
        end
      end
      do
        setmetatable(currentTabble, {__index = _G})
        local fun = loadstring("return " .. condition)
        setfenv(fun, currentTabble)
        return fun()
      end
    end
  end

  local status, msg = xpcall(loadScript, function(error)
    -- function num : 0_23_1 , upvalues : _ENV
    print(error)
  end
)
  if status and msg then
    callBack()
  end
end

debugger_exeLuaString = function()
  -- function num : 0_24 , upvalues : LuaDebugger, _ENV, loadstring, setfenv, debugger_stackInfo
  local loadScript = function()
    -- function num : 0_24_0 , upvalues : LuaDebugger, _ENV, loadstring, setfenv
    local script = (LuaDebugger.loadScriptBody).script
    if (LuaDebugger.loadScriptBody).isBreak then
      local currentTabble = {_G = _G}
      local frameId = (LuaDebugger.loadScriptBody).frameId
      local func = ((LuaDebugger.currentDebuggerData).funcs)[frameId]
      local vars = ((LuaDebugger.currentDebuggerData).vars)[frameId]
      local locals = vars.locals
      local ups = vars.ups
      for k,v in pairs(ups) do
        currentTabble[k] = v
      end
      for k,v in pairs(locals) do
        currentTabble[k] = v
      end
      setmetatable(currentTabble, {__index = _G})
      local fun = loadstring(script)
      setfenv(fun, currentTabble)
      fun()
    else
      do
        local fun = loadstring(script)
        fun()
      end
    end
  end

  local status, msg = xpcall(loadScript, function(error)
    -- function num : 0_24_1
  end
)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (LuaDebugger.loadScriptBody).script = nil
  if (LuaDebugger.loadScriptBody).isBreak then
    LuaDebugger.serVarLevel = LuaDebugger.serVarLevel + 1
    LuaDebugger.currentDebuggerData = debugger_stackInfo(LuaDebugger.serVarLevel, (LuaDebugger.event).C2S_HITBreakPoint)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (LuaDebugger.loadScriptBody).stack = (LuaDebugger.currentDebuggerData).stack
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (LuaDebugger.loadScriptBody).complete = true
end

local debugger_getTablekey = function(key, keyType, value)
  -- function num : 0_25 , upvalues : _ENV, LuaDebugger
  if keyType == -1 then
    return key
  else
    if keyType == 1 then
      return tonumber(key)
    else
      if keyType == 2 then
        local valueKey = nil
        for k,v in pairs(value) do
          local nameType = type(k)
          if (nameType == "userdata" or nameType == "table") and not LuaDebugger.isFoxGloryProject then
            valueKey = tostring(k)
            if key == valueKey then
              return k
            end
            break
          end
        end
      end
    end
  end
end

local debugger_setVarValue = function(server, data)
  -- function num : 0_26 , upvalues : LuaDebugger, _ENV, getinfo, loadstring, setfenv, debugger_getTablekey, debugger_setVarInfo, debugger_stackInfo
  local newValue = nil
  local level = LuaDebugger.serVarLevel + (LuaDebugger.setVarBody).frameId
  local firstKeyName = (data.keys)[1]
  local localValueChangeIndex = -1
  local upValueChangeIndex = -1
  local upValueFun, oldValue = nil, nil
  local i = 1
  local locals = {}
  while 1 do
    local name, value = (debug.getlocal)(level, i)
    if name then
      do
        if firstKeyName == name then
          localValueChangeIndex = i
          oldValue = value
        end
        if name ~= "(*temporary)" then
          locals[name] = value
        end
        i = i + 1
        -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local func = (getinfo(level, "f")).func
  i = 1
  local ups = {}
  while 1 do
    if func then
      local name, value = (debug.getupvalue)(func, i)
      if name then
        do
          if localValueChangeIndex == -1 and firstKeyName == name then
            upValueFun = func
            oldValue = value
            upValueChangeIndex = i
          end
          if name == "_ENV" then
            ups._ENV_ = value
          else
            ups[name] = value
          end
          i = i + 1
          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  local vars = {locals = locals, ups = ups}
  local loadScript = function()
    -- function num : 0_26_0 , upvalues : vars, _ENV, loadstring, data, setfenv, newValue
    local currentTabble = {}
    local locals = vars.locals
    local ups = vars.ups
    if ups then
      for k,v in pairs(ups) do
        currentTabble[k] = v
      end
    end
    do
      if locals then
        for k,v in pairs(locals) do
          currentTabble[k] = v
        end
      end
      do
        setmetatable(currentTabble, {__index = _G})
        local fun = loadstring("return " .. data.value)
        setfenv(fun, currentTabble)
        newValue = fun()
      end
    end
  end

  local status, msg = xpcall(loadScript, function(error)
    -- function num : 0_26_1 , upvalues : _ENV
    print(error, "============================")
  end
)
  local i = 1
  local keyLength = #data.keys
  if keyLength == 1 then
    if localValueChangeIndex ~= -1 then
      (debug.setlocal)(level, localValueChangeIndex, newValue)
    else
      if upValueFun ~= nil then
        (debug.setupvalue)(upValueFun, upValueChangeIndex, newValue)
      else
        -- DECOMPILER ERROR at PC94: Confused about usage of register: R19 in 'UnsetPending'

        if _G[firstKeyName] then
          _G[firstKeyName] = newValue
        end
      end
    end
  else
    if not oldValue and _G[firstKeyName] then
      oldValue = _G[firstKeyName]
    end
    local tempValue = oldValue
    for i = 2, keyLength - 1 do
      if tempValue then
        oldValue = oldValue[debugger_getTablekey((data.keys)[i], (data.numberTypes)[i], oldValue)]
      end
    end
    if tempValue then
      oldValue[debugger_getTablekey((data.keys)[keyLength], (data.numberTypes)[keyLength], oldValue)] = newValue
    end
  end
  do
    local varInfo = debugger_setVarInfo(data.varName, newValue)
    data.varInfo = varInfo
    LuaDebugger.serVarLevel = LuaDebugger.serVarLevel + 1
    LuaDebugger.currentDebuggerData = debugger_stackInfo(LuaDebugger.serVarLevel, (LuaDebugger.event).C2S_HITBreakPoint)
  end
end

checkSetVar = function()
  -- function num : 0_27 , upvalues : LuaDebugger, debugger_setVarValue, debug_server, _resume, coro_debugger, _ENV, checkSetVar, debugger_exeLuaString, debugger_reLoadFile
  if LuaDebugger.isSetVar then
    LuaDebugger.isSetVar = false
    debugger_setVarValue(debug_server, LuaDebugger.setVarBody)
    LuaDebugger.serVarLevel = LuaDebugger.serVarLevel + 1
    _resume(coro_debugger, LuaDebugger.setVarBody)
    xpcall(checkSetVar, function(error)
    -- function num : 0_27_0 , upvalues : _ENV
    print("设置变量", error)
  end
)
  else
    if LuaDebugger.isLoadLuaScript then
      LuaDebugger.isLoadLuaScript = false
      debugger_exeLuaString()
      LuaDebugger.serVarLevel = LuaDebugger.serVarLevel + 1
      _resume(coro_debugger, LuaDebugger.reLoadFileBody)
      xpcall(checkSetVar, function(error)
    -- function num : 0_27_1 , upvalues : _ENV
    print("执行代码", error)
  end
)
    else
      if LuaDebugger.isReLoadFile then
        LuaDebugger.isReLoadFile = false
        -- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (LuaDebugger.reLoadFileBody).isReLoad = debugger_reLoadFile(LuaDebugger.reLoadFileBody)
        print("重载结果:", (LuaDebugger.reLoadFileBody).isReLoad)
        -- DECOMPILER ERROR at PC53: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (LuaDebugger.reLoadFileBody).script = nil
        LuaDebugger.serVarLevel = LuaDebugger.serVarLevel + 1
        _resume(coro_debugger, LuaDebugger.reLoadFileBody)
        xpcall(checkSetVar, function(error)
    -- function num : 0_27_2 , upvalues : _ENV
    print("重新加载文件", error)
  end
)
      end
    end
  end
end

local getSource = function(source)
  -- function num : 0_28 , upvalues : _ENV, LuaDebugger, debugger_getFilePathInfo
  source = (string.lower)(source)
  if (LuaDebugger.pathCachePaths)[source] then
    LuaDebugger.currentLineFile = (LuaDebugger.pathCachePaths)[source]
    return (LuaDebugger.pathCachePaths)[source]
  end
  local fullName, dir, fileName = debugger_getFilePathInfo(source)
  LuaDebugger.currentLineFile = fullName
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (LuaDebugger.pathCachePaths)[source] = fileName
  return fileName
end

local debugger_GeVarInfoBytUserData = function(server, var)
  -- function num : 0_29 , upvalues : LuaDebugTool, ZZBase64, _ENV
  local fileds = (LuaDebugTool.getUserDataInfo)(var)
  local varInfos = {}
  for i = 1, fileds.Count do
    local filed = fileds[i - 1]
    local valueInfo = {name = filed.name, valueType = filed.valueType, valueStr = (ZZBase64.encode)(filed.valueStr), isValue = filed.isValue, csharp = true}
    ;
    (table.insert)(varInfos, valueInfo)
  end
  return varInfos
end

local debugger_getValueByScript = function(value, script)
  -- function num : 0_30 , upvalues : _ENV, loadstring, setfenv
  local val = nil
  local status, msg = xpcall(function()
    -- function num : 0_30_0 , upvalues : loadstring, script, setfenv, value, val
    local fun = loadstring("return " .. script)
    setfenv(fun, value)
    val = fun()
  end
, function(error)
    -- function num : 0_30_1 , upvalues : _ENV, val
    print(error, "====>")
    val = nil
  end
)
  return val
end

local debugger_getVarByKeys = function(value, keys, index)
  -- function num : 0_31 , upvalues : _ENV, debugger_getVarByKeys, debugger_getValueByScript, debugger_valueToString
  local str = ""
  local keyLength = #keys
  for i = index, keyLength do
    local key = keys[i]
    if key ~= "[metatable]" or i == index then
      if (string.find)(key, "%.") then
        if str == "" then
          i = index + 1
          value = value[key]
        end
        if #keys <= i then
          return index, value
        end
        return debugger_getVarByKeys(value, keys, i)
      else
        str = key
      end
    else
      if (string.find)(key, "%[") then
        str = str .. key
      else
        if type(key) == "string" then
          if (string.find)(key, "table:") or (string.find)(key, "userdata:") or (string.find)(key, "function:") then
            if str ~= "" then
              local vl = debugger_getValueByScript(value, str)
              value = vl
              if value then
                for k,v in pairs(value) do
                  local ktype = type(k)
                  if ktype == "userdata" or ktype == "table" or ktype == "function" then
                    local keyName = debugger_valueToString(k)
                    if keyName == key then
                      value = v
                      break
                    end
                  end
                end
              end
              do
                do
                  do
                    str = ""
                    if i == keyLength then
                      return #keys, value
                    else
                      return debugger_getVarByKeys(value, keys, i + 1)
                    end
                    str = str .. "[\"" .. key .. "\"]"
                    str = str .. "[\"" .. key .. "\"]"
                    str = str .. "[" .. key .. "]"
                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC137: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          end
        end
      end
    end
  end
  local v = debugger_getValueByScript(value, str)
  return #keys, v
end

local debugger_getCSharpValue = function(value, searchIndex, keys)
  -- function num : 0_32 , upvalues : LuaDebugTool, debugger_getCSharpValue, _ENV
  local key = keys[searchIndex]
  local val = (LuaDebugTool.getCSharpValue)(value, key)
  if val then
    if searchIndex == #keys then
      return #keys, val
    else
      local vindex, val1 = debugger_getCSharpValue(val, searchIndex + 1, keys)
      if not val1 then
        local tempKeys = {}
        for i = vindex, #keys do
          (table.insert)(tempKeys, keys[i])
        end
        local vindx, val1 = debugger_searchVarByKeys(value, searckKeys, 1)
        return vindx, val1
      else
        do
          do
            do return vindex, val1 end
            do return searchIndex, val end
          end
        end
      end
    end
  end
end

local debugger_searchVarByKeys = function(value, keys, searckKeys)
  -- function num : 0_33 , upvalues : debugger_getVarByKeys, LuaDebugTool, _ENV, debugger_getCSharpValue, debugger_searchVarByKeys
  local index, val = debugger_getVarByKeys(value, searckKeys, 1)
  if not LuaDebugTool or not LuaDebugTool.getCSharpValue or type(LuaDebugTool.getCSharpValue) ~= "function" then
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
    do
      local tempKeys = {}
      for i = 1, #searckKeys - 1 do
        (table.insert)(tempKeys, keys[i])
      end
      if #tempKeys == 0 then
        return #keys, nil
      end
      do return debugger_searchVarByKeys(value, keys, tempKeys) end
    end
  end
end

local debugger_getmetatable = function(value, metatable, vinfos, server, variablesReference, debugSpeedIndex, metatables)
  -- function num : 0_34 , upvalues : _ENV, debugger_setVarInfo, debugger_sendMsg, LuaDebugger, debugger_getmetatable
  for i,mtable in ipairs(metatables) do
    do
      if metatable == mtable then
        do
          do return vinfos end
          -- DECOMPILER ERROR at PC7: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC7: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (table.insert)(metatables, metatable)
  for k,v in pairs(metatable) do
    local val = nil
    if type(k) == "string" then
      xpcall(function()
    -- function num : 0_34_0 , upvalues : val, value, k
    val = value[k]
  end
, function(error)
    -- function num : 0_34_1 , upvalues : val
    val = nil
  end
)
      if val == nil then
        xpcall(function()
    -- function num : 0_34_2 , upvalues : _ENV, k, val, v
    if (string.find)(k, "__") then
      val = v
    end
  end
, function(error)
    -- function num : 0_34_3 , upvalues : val
    val = nil
  end
)
      end
    end
    if val then
      local vinfo = debugger_setVarInfo(k, val)
      ;
      (table.insert)(vinfos, vinfo)
      if #vinfos > 10 then
        debugger_sendMsg(server, (LuaDebugger.event).C2S_ReqVar, {variablesReference = variablesReference, debugSpeedIndex = debugSpeedIndex, vars = vinfos, isComplete = 0})
        vinfos = {}
      end
    end
  end
  local m = nil
  if getmetatable(metatable) then
    m = debugger_getmetatable
    return m(value, getmetatable(metatable), vinfos, server, variablesReference, debugSpeedIndex, metatables)
  else
    return vinfos
  end
end

local debugger_sendTableField = function(luatable, vinfos, server, variablesReference, debugSpeedIndex, valueType)
  -- function num : 0_35 , upvalues : _ENV, debugger_setVarInfo, debugger_sendMsg, LuaDebugger
  if valueType == "userdata" then
    if tolua and tolua.getpeer then
      luatable = (tolua.getpeer)(luatable)
    else
      return vinfos
    end
  end
  if luatable == nil then
    return vinfos
  end
  for k,v in pairs(luatable) do
    local vinfo = debugger_setVarInfo(k, v)
    ;
    (table.insert)(vinfos, vinfo)
    if #vinfos > 10 then
      debugger_sendMsg(server, (LuaDebugger.event).C2S_ReqVar, {variablesReference = variablesReference, debugSpeedIndex = debugSpeedIndex, vars = vinfos, isComplete = 0})
      vinfos = {}
    end
  end
  return vinfos
end

local debugger_sendTableValues = function(value, server, variablesReference, debugSpeedIndex)
  -- function num : 0_36 , upvalues : _ENV, debugger_sendTableField, LuaDebugTool, debugger_GeVarInfoBytUserData, ZZBase64, debugger_sendMsg, LuaDebugger, debugger_getmetatable
  local vinfos = {}
  local luatable = {}
  local valueType = type(value)
  local userDataInfos = {}
  local m = nil
  if valueType == "userdata" then
    m = getmetatable(value)
    vinfos = debugger_sendTableField(value, vinfos, server, variablesReference, debugSpeedIndex, valueType)
    if LuaDebugTool then
      local varInfos = debugger_GeVarInfoBytUserData(server, value, variablesReference, debugSpeedIndex)
      for i,v in ipairs(varInfos) do
        if v.valueType == "System.Byte[]" and value[v.name] and type(value[v.name]) == "string" then
          local valueInfo = {name = v.name, valueType = "string", valueStr = (ZZBase64.encode)(value[v.name])}
          ;
          (table.insert)(vinfos, valueInfo)
        else
          do
            do
              ;
              (table.insert)(vinfos, v)
              if #vinfos > 10 then
                debugger_sendMsg(server, (LuaDebugger.event).C2S_ReqVar, {variablesReference = variablesReference, debugSpeedIndex = debugSpeedIndex, vars = vinfos, isComplete = 0})
                vinfos = {}
              end
              -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  else
    do
      m = getmetatable(value)
      vinfos = debugger_sendTableField(value, vinfos, server, variablesReference, debugSpeedIndex, valueType)
      if m then
        vinfos = debugger_getmetatable(value, m, vinfos, server, variablesReference, debugSpeedIndex, {})
      end
      debugger_sendMsg(server, (LuaDebugger.event).C2S_ReqVar, {variablesReference = variablesReference, debugSpeedIndex = debugSpeedIndex, vars = vinfos, isComplete = 1})
    end
  end
end

local debugger_getBreakVar = function(body, server)
  -- function num : 0_37 , upvalues : LuaDebugger, _ENV, debugger_sendTableValues, debugger_searchVarByKeys, debugger_sendMsg, ZZBase64
  local variablesReference = body.variablesReference
  local debugSpeedIndex = body.debugSpeedIndex
  local vinfos = {}
  local exe = function()
    -- function num : 0_37_0 , upvalues : body, LuaDebugger, _ENV, debugger_sendTableValues, server, variablesReference, debugSpeedIndex, debugger_searchVarByKeys, debugger_sendMsg, ZZBase64
    local frameId = body.frameId
    local type_ = body.type
    local keys = body.keys
    local vars = nil
    if type_ == 1 then
      vars = ((LuaDebugger.currentDebuggerData).vars)[frameId + 1]
      vars = vars.locals
    else
      if type_ == 2 then
        vars = ((LuaDebugger.currentDebuggerData).vars)[frameId + 1]
        vars = vars.ups
      else
        if type_ == 3 then
          vars = _G
        end
      end
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
        debugger_sendMsg(server, (LuaDebugger.event).C2S_ReqVar, {variablesReference = variablesReference, debugSpeedIndex = debugSpeedIndex, vars = (ZZBase64.encode)(value), isComplete = 1, varType = valueType})
      end
    else
      do
        debugger_sendMsg(server, (LuaDebugger.event).C2S_ReqVar, {variablesReference = variablesReference, debugSpeedIndex = debugSpeedIndex, 
vars = {}
, isComplete = 1, varType = "nil"})
      end
    end
  end

  xpcall(exe, function(error)
    -- function num : 0_37_1 , upvalues : debugger_sendMsg, server, LuaDebugger, variablesReference, debugSpeedIndex, ZZBase64, _ENV
    debugger_sendMsg(server, (LuaDebugger.event).C2S_ReqVar, {variablesReference = variablesReference, debugSpeedIndex = debugSpeedIndex, 
vars = {
{name = "error", valueType = "string", valueStr = (ZZBase64.encode)("无法获取属性值:" .. error .. "->" .. (debug.traceback)("", 2)), isValue = false}
}
, isComplete = 1})
  end
)
end

local ResetDebugInfo = function()
  -- function num : 0_38 , upvalues : LuaDebugger
  LuaDebugger.Run = false
  LuaDebugger.StepIn = false
  LuaDebugger.StepNext = false
  LuaDebugger.StepOut = false
  LuaDebugger.StepNextLevel = 0
end

local debugger_loop = function(server)
  -- function num : 0_39 , upvalues : debug_server, LuaDebugger, _ENV, json, debugger_setBreak, ResetDebugInfo, debugger_sendMsg, debugger_getBreakVar
  server = debug_server
  local command = nil
  local eval_env = {}
  local arg = nil
  while 1 do
    while 1 do
      local line, status = server:receive()
      if status == "closed" then
        if LuaDebugger.isLaunch then
          (os.exit)()
        else
          ;
          (debug.sethook)()
          ;
          (coroutine.yield)()
        end
      end
      if line then
        local netData = (json.decode)(line)
        do
          local event = netData.event
          local body = netData.data
          if event == (LuaDebugger.event).S2C_DebugClose then
            if LuaDebugger.isLaunch then
              (os.exit)()
              break
            end
            ;
            (debug.sethook)()
            ;
            (coroutine.yield)()
            break
          end
          if event == (LuaDebugger.event).S2C_SetBreakPoints then
            do
              local setB = function()
    -- function num : 0_39_0 , upvalues : debugger_setBreak, body
    debugger_setBreak(body)
  end

              xpcall(setB, function(error)
    -- function num : 0_39_1 , upvalues : _ENV
    print(error)
  end
)
              do break end
              if event == (LuaDebugger.event).S2C_RUN then
                LuaDebugger.runTimeType = body.runTimeType
                LuaDebugger.isProntToConsole = body.isProntToConsole
                LuaDebugger.isFoxGloryProject = body.isFoxGloryProject
                LuaDebugger.isLaunch = body.isLaunch
                ResetDebugInfo()
                LuaDebugger.Run = true
                do
                  local data = (coroutine.yield)()
                  LuaDebugger.serVarLevel = 4
                  LuaDebugger.currentDebuggerData = data
                  debugger_sendMsg(server, data.event, {stack = data.stack})
                  do break end
                  if event == (LuaDebugger.event).S2C_ReqVar then
                    debugger_getBreakVar(body, server)
                    break
                  end
                  if event == (LuaDebugger.event).S2C_NextRequest then
                    ResetDebugInfo()
                    LuaDebugger.StepNext = true
                    LuaDebugger.StepNextLevel = 0
                    do
                      local data = (coroutine.yield)()
                      LuaDebugger.serVarLevel = 4
                      LuaDebugger.currentDebuggerData = data
                      debugger_sendMsg(server, data.event, {stack = data.stack})
                      do break end
                      if event == (LuaDebugger.event).S2C_StepInRequest then
                        ResetDebugInfo()
                        LuaDebugger.StepIn = true
                        do
                          local data = (coroutine.yield)()
                          LuaDebugger.serVarLevel = 4
                          LuaDebugger.currentDebuggerData = data
                          debugger_sendMsg(server, data.event, {stack = data.stack, eventType = data.eventType})
                          do break end
                          if event == (LuaDebugger.event).S2C_StepOutRequest then
                            ResetDebugInfo()
                            LuaDebugger.StepOut = true
                            do
                              local data = (coroutine.yield)()
                              LuaDebugger.serVarLevel = 4
                              LuaDebugger.currentDebuggerData = data
                              debugger_sendMsg(server, data.event, {stack = data.stack, eventType = data.eventType})
                              do break end
                              if event == (LuaDebugger.event).S2C_LoadLuaScript then
                                LuaDebugger.loadScriptBody = body
                                LuaDebugger.isLoadLuaScript = true
                                do
                                  local data = (coroutine.yield)()
                                  debugger_sendMsg(server, (LuaDebugger.event).C2S_LoadLuaScript, LuaDebugger.loadScriptBody)
                                  do break end
                                  if event == (LuaDebugger.event).S2C_SerVar then
                                    LuaDebugger.isSetVar = true
                                    LuaDebugger.setVarBody = body
                                    do
                                      local data = (coroutine.yield)()
                                      debugger_sendMsg(server, (LuaDebugger.event).C2S_SerVar, {stack = data, eventType = data.eventType})
                                      do break end
                                      if event == (LuaDebugger.event).S2C_ReLoadFile then
                                        LuaDebugger.isReLoadFile = true
                                        LuaDebugger.reLoadFileBody = body
                                        local data = (coroutine.yield)()
                                        debugger_sendMsg(server, (LuaDebugger.event).C2S_ReLoadFile, {stack = data, eventType = data.eventType})
                                      end
                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out DO_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out DO_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out DO_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out DO_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out DO_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out DO_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out DO_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out DO_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                      -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_STMT

                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    -- DECOMPILER ERROR at PC212: LeaveBlock: unexpected jumping out WHILE_STMT

    -- DECOMPILER ERROR at PC212: LeaveBlock: unexpected jumping out FUNCTION_STMT

    -- DECOMPILER ERROR at PC212: LeaveBlock: cannot find end of DO_STMT , stop at FUNCTION_STMT

  end
  -- DECOMPILER ERROR at PC212: LeaveBlock: unexpected jumping out FUNCTION_STMT

  -- DECOMPILER ERROR at PC212: LeaveBlock: cannot find end of WHILE_STMT , stop at FUNCTION_STMT

end

coro_debugger = (coroutine.create)(debugger_loop)
debug_hook = function(event, line)
  -- function num : 0_40 , upvalues : LuaDebugger, _ENV, getinfo, ResetDebugInfo, debugger_stackInfo, _resume, coro_debugger, checkSetVar, getSource, splitFilePath
  if not LuaDebugger.isHook then
    return 
  end
  if LuaDebugger.Run then
    if event == "line" then
      local isCheck = false
      for k,breakInfo in pairs(LuaDebugger.breakInfos) do
        do
          for bk,linesInfo in pairs(breakInfo) do
            if linesInfo.lines and (linesInfo.lines)[line] then
              isCheck = true
              break
            end
          end
        end
      end
      do
        do
          if isCheck or not isCheck then
            return 
          end
          LuaDebugger.currentFileName = nil
          LuaDebugger.currentTempFunc = nil
          do return  end
          if LuaDebugger.StepOut then
            if event == "line" or event == "call" then
              return 
            end
            local tempFun = (getinfo(2, "f")).func
            if (LuaDebugger.currentDebuggerData).funcsLength == 1 then
              ResetDebugInfo()
              LuaDebugger.Run = true
            else
              if ((LuaDebugger.currentDebuggerData).funcs)[2] == tempFun then
                local data = debugger_stackInfo(3, (LuaDebugger.event).C2S_StepInResponse)
                _resume(coro_debugger, data)
                checkSetVar()
              end
            end
            do
              do
                do return  end
                local file = nil
                if event == "call" then
                  if not LuaDebugger.Run then
                    LuaDebugger.StepNextLevel = LuaDebugger.StepNextLevel + 1
                  end
                  local stepInfo = getinfo(2, "S")
                  local source = stepInfo.source
                  if source:find(LuaDebugger.DebugLuaFie) or source == "=[C]" then
                    return 
                  end
                  file = getSource(source)
                  LuaDebugger.currentFileName = file
                else
                  do
                    if event == "return" or event == "tail return" then
                      if not LuaDebugger.Run then
                        LuaDebugger.StepNextLevel = LuaDebugger.StepNextLevel - 1
                      end
                      LuaDebugger.currentFileName = nil
                    else
                      if event == "line" then
                        local isHit = false
                        local stepInfo = nil
                        if not LuaDebugger.currentFileName then
                          stepInfo = getinfo(2, "S")
                          local source = stepInfo.source
                          if source == "=[C]" or source:find(LuaDebugger.DebugLuaFie) then
                            return 
                          end
                          file = getSource(source)
                          LuaDebugger.currentFileName = file
                        end
                        do
                          file = LuaDebugger.currentFileName
                          local breakInfo = (LuaDebugger.breakInfos)[file]
                          local breakData = nil
                          if breakInfo then
                            local ischeck = false
                            for k,lineInfo in pairs(breakInfo) do
                              local lines = lineInfo.lines
                              if lines and lines[line] then
                                ischeck = true
                                break
                              end
                            end
                            do
                              if ischeck then
                                local hitPathNames = splitFilePath(LuaDebugger.currentLineFile)
                                local hitCounts = {}
                                local debugHitCounts = nil
                                for k,lineInfo in pairs(breakInfo) do
                                  local lines = lineInfo.lines
                                  local pathNames = lineInfo.pathNames
                                  debugHitCounts = lineInfo.hitCounts
                                  if lines and lines[line] then
                                    breakData = lines[line]
                                    hitCounts[k] = 0
                                    local hitPathNamesCount = #hitPathNames
                                    local pathNamesCount = #pathNames
                                    local checkCount = 0
                                    while pathNames[pathNamesCount] == hitPathNames[hitPathNamesCount] do
                                      hitCounts[k] = hitCounts[k] + 1
                                      pathNamesCount = pathNamesCount - 1
                                      hitPathNamesCount = hitPathNamesCount - 1
                                      checkCount = checkCount + 1
                                    end
                                    if pathNamesCount <= 0 or hitPathNamesCount <= 0 or checkCount <= 0 then
                                      do
                                        do
                                          if checkCount == 0 then
                                            breakData = nil
                                          end
                                          breakData = nil
                                          -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out DO_STMT

                                          -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC211: LeaveBlock: unexpected jumping out IF_STMT

                                        end
                                      end
                                    end
                                  end
                                end
                                if breakData then
                                  local hitFieName = ""
                                  local maxCount = 0
                                  for k,v in pairs(hitCounts) do
                                    if maxCount < v then
                                      maxCount = v
                                      hitFieName = k
                                    end
                                  end
                                  local hitPathNamesLength = #hitPathNames
                                  if (hitPathNamesLength == 1 or hitPathNamesLength <= 1 or maxCount > 1) and hitFieName ~= "" then
                                    local hitCount = breakData.hitCondition
                                    local clientHitCount = debugHitCounts[breakData.line]
                                    clientHitCount = clientHitCount + 1
                                    debugHitCounts[breakData.line] = clientHitCount
                                    if hitCount <= clientHitCount then
                                      isHit = true
                                    end
                                  end
                                end
                              end
                              do
                                do
                                  if LuaDebugger.StepIn then
                                    local data = debugger_stackInfo(3, (LuaDebugger.event).C2S_NextResponse)
                                    if data then
                                      LuaDebugger.currentTempFunc = (data.funcs)[1]
                                      _resume(coro_debugger, data)
                                      checkSetVar()
                                      return 
                                    end
                                  end
                                  do
                                    if LuaDebugger.StepNext and LuaDebugger.StepNextLevel <= 0 then
                                      local data = debugger_stackInfo(3, (LuaDebugger.event).C2S_NextResponse)
                                      if data then
                                        LuaDebugger.currentTempFunc = (data.funcs)[1]
                                        _resume(coro_debugger, data)
                                        checkSetVar()
                                        return 
                                      end
                                    end
                                    if isHit then
                                      local data = debugger_stackInfo(3, (LuaDebugger.event).C2S_HITBreakPoint)
                                      if breakData and breakData.condition then
                                        debugger_conditionStr(breakData.condition, data.vars, function()
    -- function num : 0_40_0 , upvalues : _resume, coro_debugger, data, checkSetVar
    _resume(coro_debugger, data)
    checkSetVar()
  end
)
                                      else
                                        _resume(coro_debugger, data)
                                        checkSetVar()
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

debugger_xpcall = function()
  -- function num : 0_41 , upvalues : debugger_stackInfo, LuaDebugger, _resume, coro_debugger, checkSetVar
  local data = debugger_stackInfo(4, (LuaDebugger.event).C2S_HITBreakPoint)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  if data.stack and (data.stack)[1] then
    ((data.stack)[1]).isXpCall = true
  end
  _resume(coro_debugger, data)
  checkSetVar()
end

local start = function()
  -- function num : 0_42 , upvalues : debugger_getFilePathInfo, getinfo, LuaDebugger, createSocket, _ENV, controller_host, controller_port, debug_server, breakInfoSocket, debugger_sendMsg, debug_hook, _resume, coro_debugger
  local fullName, dirName, fileName = debugger_getFilePathInfo((getinfo(1)).source)
  LuaDebugger.DebugLuaFie = fileName
  local socket = createSocket()
  print(controller_host)
  print(controller_port)
  local server = (socket.connect)(controller_host, controller_port)
  debug_server = server
  if server then
    socket = createSocket()
    breakInfoSocket = (socket.connect)(controller_host, controller_port)
    if breakInfoSocket then
      breakInfoSocket:settimeout(0)
      debugger_sendMsg(breakInfoSocket, (LuaDebugger.event).C2S_SetSocketName, {name = "breakPointSocket"})
      debugger_sendMsg(server, (LuaDebugger.event).C2S_SetSocketName, {name = "mainSocket", version = LuaDebugger.version})
      xpcall(function()
    -- function num : 0_42_0 , upvalues : _ENV, debug_hook
    (debug.sethook)(debug_hook, "lrc")
  end
, function(error)
    -- function num : 0_42_1 , upvalues : _ENV
    print("error:", error)
  end
)
      if jit and LuaDebugger.debugLuaType ~= "jit" then
        print("error======================================================")
        local msg = "当前luajit版本为: " .. jit.version .. " 请使用LuaDebugjit 进行调试!"
        print(msg)
      end
      do
        _resume(coro_debugger, server)
      end
    end
  end
end

StartDebug = function(host, port, reLoad)
  -- function num : 0_43 , upvalues : _ENV, controller_host, controller_port, start, debugger_reLoadFile, debugger_receiveDebugBreakInfo, debugger_xpcall
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
    -- function num : 0_43_0 , upvalues : _ENV
    print(error)
  end
)
  if isReLoad then
    xpcall(function()
    -- function num : 0_43_1 , upvalues : debugger_reLoadFile, _ENV
    debugger_reLoadFile = require("luaideReLoadFile")
  end
, function()
    -- function num : 0_43_2 , upvalues : _ENV, debugger_reLoadFile
    print("左侧luaide按钮->打开luaIde最新调试文件所在文件夹->luaideReLoadFile.lua->拷贝到项目中")
    print("具体使用方式请看luaideReLoadFile中文件注释")
    debugger_reLoadFile = function()
      -- function num : 0_43_2_0 , upvalues : _ENV
      print("未实现代码重载")
    end

  end
)
  end
  return debugger_receiveDebugBreakInfo, debugger_xpcall
end

local string = string
ZZBase64.__code = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "/"}
ZZBase64.__decode = {}
for k,v in pairs(ZZBase64.__code) do
  -- DECOMPILER ERROR at PC242: Confused about usage of register: R61 in 'UnsetPending'

  (ZZBase64.__decode)[(string.byte)(v, 1)] = k - 1
end
ZZBase64.encode = function(text)
  -- function num : 0_44 , upvalues : string, _ENV, ZZBase64
  local len = (string.len)(text)
  local left = len % 3
  len = len - left
  local res = {}
  local index = 1
  for i = 1, len, 3 do
    local a = (string.byte)(text, i)
    local b = (string.byte)(text, i + 1)
    local c = (string.byte)(text, i + 2)
    local num = a * 65536 + b * 256 + c
    for j = 1, 4 do
      local tmp = (math.floor)(num / 2 ^ ((4 - j) * 6))
      local curPos = tmp % 64 + 1
      res[index] = (ZZBase64.__code)[curPos]
      index = index + 1
    end
  end
  if left == 1 then
    (ZZBase64.__left1)(res, index, text, len)
  else
    if left == 2 then
      (ZZBase64.__left2)(res, index, text, len)
    end
  end
  return (table.concat)(res)
end

ZZBase64.__left2 = function(res, index, text, len)
  -- function num : 0_45 , upvalues : string, _ENV, ZZBase64
  local num1 = (string.byte)(text, len + 1)
  num1 = num1 * 1024
  local num2 = (string.byte)(text, len + 2)
  num2 = num2 * 4
  local num = num1 + num2
  local tmp1 = (math.floor)(num / 4096)
  local curPos = tmp1 % 64 + 1
  res[index] = (ZZBase64.__code)[curPos]
  local tmp2 = (math.floor)(num / 64)
  curPos = tmp2 % 64 + 1
  res[index + 1] = (ZZBase64.__code)[curPos]
  curPos = num % 64 + 1
  res[index + 2] = (ZZBase64.__code)[curPos]
  res[index + 3] = "="
end

ZZBase64.__left1 = function(res, index, text, len)
  -- function num : 0_46 , upvalues : string, _ENV, ZZBase64
  local num = (string.byte)(text, len + 1)
  num = num * 16
  local tmp = (math.floor)(num / 64)
  local curPos = tmp % 64 + 1
  res[index] = (ZZBase64.__code)[curPos]
  curPos = num % 64 + 1
  res[index + 1] = (ZZBase64.__code)[curPos]
  res[index + 2] = "="
  res[index + 3] = "="
end

ZZBase64.decode = function(text)
  -- function num : 0_47 , upvalues : string, ZZBase64, _ENV
  local len = (string.len)(text)
  local left = 0
  if (string.sub)(text, len - 1) == "==" then
    left = 2
    len = len - 4
  else
    if (string.sub)(text, len) == "=" then
      left = 1
      len = len - 4
    end
  end
  local res = {}
  local index = 1
  local decode = ZZBase64.__decode
  for i = 1, len, 4 do
    local a = decode[(string.byte)(text, i)]
    local b = decode[(string.byte)(text, i + 1)]
    local c = decode[(string.byte)(text, i + 2)]
    local d = decode[(string.byte)(text, i + 3)]
    local num = a * 262144 + b * 4096 + c * 64 + d
    local e = (string.char)(num % 256)
    num = (math.floor)(num / 256)
    local f = (string.char)(num % 256)
    num = (math.floor)(num / 256)
    res[index] = (string.char)(num % 256)
    res[index + 1] = f
    res[index + 2] = e
    index = index + 3
  end
  if left == 1 then
    (ZZBase64.__decodeLeft1)(res, index, text, len)
  else
    if left == 2 then
      (ZZBase64.__decodeLeft2)(res, index, text, len)
    end
  end
  return (table.concat)(res)
end

ZZBase64.__decodeLeft1 = function(res, index, text, len)
  -- function num : 0_48 , upvalues : ZZBase64, string, _ENV
  local decode = ZZBase64.__decode
  local a = decode[(string.byte)(text, len + 1)]
  local b = decode[(string.byte)(text, len + 2)]
  local c = decode[(string.byte)(text, len + 3)]
  local num = a * 4096 + b * 64 + c
  local num1 = (math.floor)(num / 1024) % 256
  local num2 = (math.floor)(num / 4) % 256
  res[index] = (string.char)(num1)
  res[index + 1] = (string.char)(num2)
end

ZZBase64.__decodeLeft2 = function(res, index, text, len)
  -- function num : 0_49 , upvalues : ZZBase64, string, _ENV
  local decode = ZZBase64.__decode
  local a = decode[(string.byte)(text, len + 1)]
  local b = decode[(string.byte)(text, len + 2)]
  local num = a * 64 + b
  num = (math.floor)(num / 16)
  res[index] = (string.char)(num)
end

return StartDebug

