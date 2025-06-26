-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sbuyreturngift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBuyReturnGift = dataclass("SBuyReturnGift", require("framework.net.protocol"))
SBuyReturnGift.ProtocolType = 3647
SBuyReturnGift.MaxSize = 65535
SBuyReturnGift.giftID = 0
SBuyReturnGift.result = 0
SBuyReturnGift.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBuyReturnGift
  ((SBuyReturnGift.super).Ctor)(self, client)
end

SBuyReturnGift.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.giftID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

SBuyReturnGift.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SBuyReturnGift

