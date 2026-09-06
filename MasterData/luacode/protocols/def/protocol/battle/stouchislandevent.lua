local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local STouchIslandEvent = dataclass("STouchIslandEvent", require("framework.net.protocol"))
STouchIslandEvent.ProtocolType = 1984
STouchIslandEvent.MaxSize = 65535
STouchIslandEvent.islandId = 0
STouchIslandEvent.result = 0

function STouchIslandEvent:Ctor(client)
  STouchIslandEvent.super.Ctor(self, client)
  self.awardItems = {}
end

function STouchIslandEvent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.islandId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  local length = table.slen(self.awardItems)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.awardItems[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function STouchIslandEvent:Unmarshal(buffer)
  local ret = true
  ret, self.islandId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.awardItems[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.awardItems[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return STouchIslandEvent
