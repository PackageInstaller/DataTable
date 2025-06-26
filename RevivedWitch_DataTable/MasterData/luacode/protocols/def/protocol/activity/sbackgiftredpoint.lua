-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sbackgiftredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBackGiftRedPoint = dataclass("SBackGiftRedPoint", require("framework.net.protocol"))
SBackGiftRedPoint.ProtocolType = 2574
SBackGiftRedPoint.MaxSize = 65535
SBackGiftRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBackGiftRedPoint
  ((SBackGiftRedPoint.super).Ctor)(self, client)
end

SBackGiftRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SBackGiftRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SBackGiftRedPoint

