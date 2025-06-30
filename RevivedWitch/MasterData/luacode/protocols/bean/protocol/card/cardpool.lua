-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/card/cardpool.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CardPool = dataclass("CardPool")
CardPool.itemid = 0
CardPool.itemnum = 0
CardPool.itemidTen = 0
CardPool.itemnumTen = 0
CardPool.chargeItemNumTen = 0
CardPool.chargeItemIdTen = 0
CardPool.moneyId = 0
CardPool.moneyNum = 0
CardPool.moneyIdTen = 0
CardPool.moneyNumTen = 0
CardPool.baoDiNums = 0
CardPool.upBaoDiNums = 0
CardPool.display = 0
CardPool.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.drawCardDetails = ((require("protocols.bean.protocol.card.drawcarddetails")).Create)()
end

CardPool.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemnum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemidTen) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemnumTen) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chargeItemNumTen) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chargeItemIdTen) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.moneyId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.moneyNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.moneyIdTen) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.moneyNumTen) then
    return false
  end
  if not (self.drawCardDetails):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.baoDiNums) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.upBaoDiNums) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.display) then
    return false
  end
  return true
end

CardPool.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.drawCardDetails):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
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

return CardPool

