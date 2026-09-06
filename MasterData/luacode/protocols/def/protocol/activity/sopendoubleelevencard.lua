local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenDoubleElevenCard = dataclass("SOpenDoubleElevenCard", require("framework.net.protocol"))
SOpenDoubleElevenCard.ProtocolType = 2524
SOpenDoubleElevenCard.MaxSize = 65535
SOpenDoubleElevenCard.poolId = 0
SOpenDoubleElevenCard.position = 0
SOpenDoubleElevenCard.cardType = 0
SOpenDoubleElevenCard.NORMAL_CARD = 0
SOpenDoubleElevenCard.GOLD_CARD = 1

function SOpenDoubleElevenCard:Ctor(client)
  SOpenDoubleElevenCard.super.Ctor(self, client)
  self.itemInfo = require("protocols.bean.protocol.item.beans.iteminfo").Create()
end

function SOpenDoubleElevenCard:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.poolId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.position) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.cardType) then
    return false
  end
  if not self.itemInfo:Marshal(buffer) then
    return false
  end
  return true
end

function SOpenDoubleElevenCard:Unmarshal(buffer)
  local ret = true
  ret, self.poolId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.position = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.cardType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.itemInfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SOpenDoubleElevenCard
