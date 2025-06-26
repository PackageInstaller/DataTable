-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/copendrawcardlog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenDrawCardLog = dataclass("COpenDrawCardLog", require("framework.net.protocol"))
COpenDrawCardLog.ProtocolType = 1510
COpenDrawCardLog.MaxSize = 65535
COpenDrawCardLog.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenDrawCardLog
  ((COpenDrawCardLog.super).Ctor)(self, client)
end

COpenDrawCardLog.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenDrawCardLog.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenDrawCardLog

