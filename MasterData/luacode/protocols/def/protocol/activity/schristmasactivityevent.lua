local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChristmasActivityEvent = dataclass("SChristmasActivityEvent", require("framework.net.protocol"))
SChristmasActivityEvent.ProtocolType = 2529
SChristmasActivityEvent.MaxSize = 65535
SChristmasActivityEvent.result = 0
SChristmasActivityEvent.constructionID = 0
SChristmasActivityEvent.eventID = 0

function SChristmasActivityEvent:Ctor(client)
  SChristmasActivityEvent.super.Ctor(self, client)
end

function SChristmasActivityEvent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.constructionID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.eventID) then
    return false
  end
  return true
end

function SChristmasActivityEvent:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.constructionID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.eventID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChristmasActivityEvent
