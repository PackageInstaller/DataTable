-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetloveractivityinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetLoverActivityInfo = dataclass("CGetLoverActivityInfo", require("framework.net.protocol"))
CGetLoverActivityInfo.ProtocolType = 2588
CGetLoverActivityInfo.MaxSize = 65535
CGetLoverActivityInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetLoverActivityInfo
  ((CGetLoverActivityInfo.super).Ctor)(self, client)
end

CGetLoverActivityInfo.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CGetLoverActivityInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CGetLoverActivityInfo

