-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetchristmasactivityinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetChristmasActivityInfo = dataclass("CGetChristmasActivityInfo", require("framework.net.protocol"))
CGetChristmasActivityInfo.ProtocolType = 2525
CGetChristmasActivityInfo.MaxSize = 65535
CGetChristmasActivityInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetChristmasActivityInfo
  ((CGetChristmasActivityInfo.super).Ctor)(self, client)
end

CGetChristmasActivityInfo.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CGetChristmasActivityInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CGetChristmasActivityInfo

