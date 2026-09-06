local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChoosePointEvent = dataclass("CChoosePointEvent", require("framework.net.protocol"))
CChoosePointEvent.ProtocolType = 2418
CChoosePointEvent.MaxSize = 65535
CChoosePointEvent.pointID = 0
CChoosePointEvent.eventIndex = 0
CChoosePointEvent.eventChoice = 0

function CChoosePointEvent:Ctor(client)
  CChoosePointEvent.super.Ctor(self, client)
end

function CChoosePointEvent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pointID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.eventIndex) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.eventChoice) then
    return false
  end
  return true
end

function CChoosePointEvent:Unmarshal(buffer)
  local ret = true
  ret, self.pointID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.eventIndex = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.eventChoice = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChoosePointEvent
