-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/cbuydailygift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBuyDailyGift = dataclass("CBuyDailyGift", require("framework.net.protocol"))
CBuyDailyGift.ProtocolType = 3627
CBuyDailyGift.MaxSize = 65535
CBuyDailyGift.giftID = 0
CBuyDailyGift.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBuyDailyGift
  ((CBuyDailyGift.super).Ctor)(self, client)
end

CBuyDailyGift.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.giftID) then
    return false
  end
  return true
end

CBuyDailyGift.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CBuyDailyGift

