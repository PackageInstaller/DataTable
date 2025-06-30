-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetsummeractivityinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetSummerActivityInfo = dataclass("CGetSummerActivityInfo", require("framework.net.protocol"))
CGetSummerActivityInfo.ProtocolType = 2469
CGetSummerActivityInfo.MaxSize = 65535
CGetSummerActivityInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetSummerActivityInfo
  ((CGetSummerActivityInfo.super).Ctor)(self, client)
end

CGetSummerActivityInfo.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CGetSummerActivityInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CGetSummerActivityInfo

