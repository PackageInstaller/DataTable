local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDrawCard = dataclass("SDrawCard", require("framework.net.protocol"))
SDrawCard.ProtocolType = 1504
SDrawCard.MaxSize = 65535
SDrawCard.baodiNum = 0
SDrawCard.drawCardType = 0
SDrawCard.share = 0
SDrawCard.curDayTimes = 0

function SDrawCard:Ctor(client)
  SDrawCard.super.Ctor(self, client)
  self.cards = {}
  self.items = {}
end

function SDrawCard:Marshal(buffer)
  local length = table.slen(self.cards)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.cards[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.items)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.items[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.baodiNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.drawCardType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.share) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.curDayTimes) then
    return false
  end
  return true
end

function SDrawCard:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.cards[i] = require("protocols.bean.protocol.card.cardinfo").Create()
    if not self.cards[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.items[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.items[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.baodiNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.drawCardType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.share = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.curDayTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SDrawCard
