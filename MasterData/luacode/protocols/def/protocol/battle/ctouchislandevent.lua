local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CTouchIslandEvent = dataclass("CTouchIslandEvent", require("framework.net.protocol"))
CTouchIslandEvent.ProtocolType = 1983
CTouchIslandEvent.MaxSize = 65535
CTouchIslandEvent.islandID = 0
CTouchIslandEvent.event = 0

function CTouchIslandEvent:Ctor(client)
  CTouchIslandEvent.super.Ctor(self, client)
end

function CTouchIslandEvent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.islandID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.event) then
    return false
  end
  return true
end

function CTouchIslandEvent:Unmarshal(buffer)
  local ret = true
  ret, self.islandID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.event = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CTouchIslandEvent
