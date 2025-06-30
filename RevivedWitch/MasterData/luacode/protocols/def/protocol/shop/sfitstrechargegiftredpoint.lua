-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sfitstrechargegiftredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SFitstRechargeGiftRedPoint = dataclass("SFitstRechargeGiftRedPoint", require("framework.net.protocol"))
SFitstRechargeGiftRedPoint.ProtocolType = 3632
SFitstRechargeGiftRedPoint.MaxSize = 65535
SFitstRechargeGiftRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SFitstRechargeGiftRedPoint
  ((SFitstRechargeGiftRedPoint.super).Ctor)(self, client)
end

SFitstRechargeGiftRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SFitstRechargeGiftRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SFitstRechargeGiftRedPoint

