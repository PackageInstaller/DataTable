local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
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

function CardPool:Ctor()
  self.drawCardDetails = require("protocols.bean.protocol.card.drawcarddetails").Create()
end

function CardPool:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemnum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemidTen) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemnumTen) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chargeItemNumTen) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chargeItemIdTen) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.moneyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.moneyNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.moneyIdTen) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.moneyNumTen) then
    return false
  end
  if not self.drawCardDetails:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.baoDiNums) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.upBaoDiNums) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.display) then
    return false
  end
  return true
end

function CardPool:Unmarshal(buffer)
  local ret = true
  ret, self.itemid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemnum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemidTen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemnumTen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.chargeItemNumTen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.chargeItemIdTen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.moneyId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.moneyNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.moneyIdTen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.moneyNumTen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.drawCardDetails:Unmarshal(buffer) then
    return false
  end
  ret, self.baoDiNums = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.upBaoDiNums = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.display = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CardPool
