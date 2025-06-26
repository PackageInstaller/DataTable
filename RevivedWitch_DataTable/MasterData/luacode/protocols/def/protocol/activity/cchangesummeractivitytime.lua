-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cchangesummeractivitytime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChangeSummerActivityTime = dataclass("CChangeSummerActivityTime", require("framework.net.protocol"))
CChangeSummerActivityTime.ProtocolType = 2477
CChangeSummerActivityTime.MaxSize = 65535
CChangeSummerActivityTime.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChangeSummerActivityTime
  ((CChangeSummerActivityTime.super).Ctor)(self, client)
end

CChangeSummerActivityTime.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CChangeSummerActivityTime.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CChangeSummerActivityTime

