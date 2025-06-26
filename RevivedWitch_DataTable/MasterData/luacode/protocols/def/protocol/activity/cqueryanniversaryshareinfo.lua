-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cqueryanniversaryshareinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CQueryAnniversaryShareInfo = dataclass("CQueryAnniversaryShareInfo", require("framework.net.protocol"))
CQueryAnniversaryShareInfo.ProtocolType = 2692
CQueryAnniversaryShareInfo.MaxSize = 65535
CQueryAnniversaryShareInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CQueryAnniversaryShareInfo
  ((CQueryAnniversaryShareInfo.super).Ctor)(self, client)
end

CQueryAnniversaryShareInfo.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CQueryAnniversaryShareInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CQueryAnniversaryShareInfo

