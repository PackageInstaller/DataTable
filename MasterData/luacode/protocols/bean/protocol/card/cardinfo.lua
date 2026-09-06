local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CardInfo = dataclass("CardInfo")
CardInfo.cardtype = 0
CardInfo.cardId = 0
CardInfo.isNew = 0
CardInfo.ITEM = 1
CardInfo.ROLE = 2

function CardInfo:Ctor()
  self.item = require("protocols.bean.protocol.item.beans.iteminfo").Create()
end

function CardInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.cardtype) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.cardId) then
    return false
  end
  if not self.item:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.isNew) then
    return false
  end
  return true
end

function CardInfo:Unmarshal(buffer)
  local ret = true
  ret, self.cardtype = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.cardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.item:Unmarshal(buffer) then
    return false
  end
  ret, self.isNew = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CardInfo
