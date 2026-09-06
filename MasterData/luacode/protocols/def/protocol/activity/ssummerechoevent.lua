local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSummerEchoEvent = dataclass("SSummerEchoEvent", require("framework.net.protocol"))
SSummerEchoEvent.ProtocolType = 2707
SSummerEchoEvent.MaxSize = 65535
SSummerEchoEvent.result = 0
SSummerEchoEvent.constructionID = 0
SSummerEchoEvent.eventID = 0

function SSummerEchoEvent:Ctor(client)
  SSummerEchoEvent.super.Ctor(self, client)
end

function SSummerEchoEvent:Marshal(buffer)
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

function SSummerEchoEvent:Unmarshal(buffer)
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

return SSummerEchoEvent
