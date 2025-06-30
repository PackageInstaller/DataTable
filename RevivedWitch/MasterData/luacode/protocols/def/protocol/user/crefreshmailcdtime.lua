-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/crefreshmailcdtime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReFreshMailCDTime = dataclass("CReFreshMailCDTime", require("framework.net.protocol"))
CReFreshMailCDTime.ProtocolType = 2275
CReFreshMailCDTime.MaxSize = 65535
CReFreshMailCDTime.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReFreshMailCDTime
  ((CReFreshMailCDTime.super).Ctor)(self, client)
end

CReFreshMailCDTime.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CReFreshMailCDTime.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CReFreshMailCDTime

