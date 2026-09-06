local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveDungeonPointAward = dataclass("SReceiveDungeonPointAward", require("framework.net.protocol"))
SReceiveDungeonPointAward.ProtocolType = 1962
SReceiveDungeonPointAward.MaxSize = 65535
SReceiveDungeonPointAward.id = 0

function SReceiveDungeonPointAward:Ctor(client)
  SReceiveDungeonPointAward.super.Ctor(self, client)
  self.items = {}
end

function SReceiveDungeonPointAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
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
  return true
end

function SReceiveDungeonPointAward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  return ret
end

return SReceiveDungeonPointAward
