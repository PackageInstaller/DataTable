local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSummerActivityEvent = dataclass("SSummerActivityEvent", require("framework.net.protocol"))
SSummerActivityEvent.ProtocolType = 2501
SSummerActivityEvent.MaxSize = 65535
SSummerActivityEvent.result = 0
SSummerActivityEvent.constructionID = 0
SSummerActivityEvent.eventID = 0

function SSummerActivityEvent:Ctor(client)
  SSummerActivityEvent.super.Ctor(self, client)
end

function SSummerActivityEvent:Marshal(buffer)
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

function SSummerActivityEvent:Unmarshal(buffer)
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

return SSummerActivityEvent
