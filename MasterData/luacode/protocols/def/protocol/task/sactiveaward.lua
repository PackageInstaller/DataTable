local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SActiveAward = dataclass("SActiveAward", require("framework.net.protocol"))
SActiveAward.ProtocolType = 1613
SActiveAward.MaxSize = 65535
SActiveAward.activeValue = 0
SActiveAward.gold = 0

function SActiveAward:Ctor(client)
  SActiveAward.super.Ctor(self, client)
  self.itemList = {}
end

function SActiveAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activeValue) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.gold) then
    return false
  end
  local length = table.slen(self.itemList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.itemList[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SActiveAward:Unmarshal(buffer)
  local ret = true
  ret, self.activeValue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.gold = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.itemList[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.itemList[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SActiveAward
