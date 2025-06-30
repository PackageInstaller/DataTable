-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetsummerechoinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetSummerEchoInfo = dataclass("CGetSummerEchoInfo", require("framework.net.protocol"))
CGetSummerEchoInfo.ProtocolType = 2703
CGetSummerEchoInfo.MaxSize = 65535
CGetSummerEchoInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetSummerEchoInfo
  ((CGetSummerEchoInfo.super).Ctor)(self, client)
end

CGetSummerEchoInfo.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CGetSummerEchoInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CGetSummerEchoInfo

