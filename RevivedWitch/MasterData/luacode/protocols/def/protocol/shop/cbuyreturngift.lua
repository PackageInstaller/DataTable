-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/cbuyreturngift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBuyReturnGift = dataclass("CBuyReturnGift", require("framework.net.protocol"))
CBuyReturnGift.ProtocolType = 3646
CBuyReturnGift.MaxSize = 65535
CBuyReturnGift.giftID = 0
CBuyReturnGift.giftType = 0
CBuyReturnGift.INVITATE = 1
CBuyReturnGift.RETURN = 2
CBuyReturnGift.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBuyReturnGift
  ((CBuyReturnGift.super).Ctor)(self, client)
end

CBuyReturnGift.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.giftID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.giftType) then
    return false
  end
  return true
end

CBuyReturnGift.Unmarshal = function(self, buffer)
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

return CBuyReturnGift

