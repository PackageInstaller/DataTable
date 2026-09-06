local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenTowerIslandChest = dataclass("SOpenTowerIslandChest", require("framework.net.protocol"))
SOpenTowerIslandChest.ProtocolType = 1986
SOpenTowerIslandChest.MaxSize = 65535
SOpenTowerIslandChest.islandID = 0
SOpenTowerIslandChest.resultType = 0
SOpenTowerIslandChest.effect = 0

function SOpenTowerIslandChest:Ctor(client)
  SOpenTowerIslandChest.super.Ctor(self, client)
  self.items = {}
end

function SOpenTowerIslandChest:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.islandID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.resultType) then
    return false
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.effect) then
    return false
  end
  return true
end

function SOpenTowerIslandChest:Unmarshal(buffer)
  local ret = true
  ret, self.islandID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.resultType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
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
  ret, self.effect = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenTowerIslandChest
