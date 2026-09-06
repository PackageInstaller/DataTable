local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDrawCard = dataclass("CDrawCard", require("framework.net.protocol"))
CDrawCard.ProtocolType = 1503
CDrawCard.MaxSize = 65535
CDrawCard.WaitProtocol = "protocol.notify.scancelloading"
CDrawCard.poolId = 0
CDrawCard.drawType = 0
CDrawCard.costType = 0
CDrawCard.TYPE_ONE = 1
CDrawCard.TYPE_TEN = 2
CDrawCard.TYPE_TWO = 3
CDrawCard.TYPE_CHARGE_TEN = 4
CDrawCard.ITEM_COST_SOUL = 1
CDrawCard.ITEM_COST_ORDINARY = 2

function CDrawCard:Ctor(client)
  CDrawCard.super.Ctor(self, client)
end

function CDrawCard:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.poolId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.drawType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.costType) then
    return false
  end
  return true
end

function CDrawCard:Unmarshal(buffer)
  local ret = true
  ret, self.poolId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.drawType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.costType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDrawCard
