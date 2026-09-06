local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSummerActivityEvent = dataclass("CSummerActivityEvent", require("framework.net.protocol"))
CSummerActivityEvent.ProtocolType = 2500
CSummerActivityEvent.MaxSize = 65535
CSummerActivityEvent.constructionID = 0
CSummerActivityEvent.eventID = 0
CSummerActivityEvent.lineupID = 0
CSummerActivityEvent.MAINLINE_DRAMA = 1
CSummerActivityEvent.MAINLINE_BATTLE = 2
CSummerActivityEvent.SIDE_DRAMA = 3
CSummerActivityEvent.FREEDOM_BATTLE = 4
CSummerActivityEvent.SUMMER_SHOP = 5
CSummerActivityEvent.SUMMER_SNACK = 6
CSummerActivityEvent.WATERMELON = 7
CSummerActivityEvent.DISPLAY_ROOM = 8

function CSummerActivityEvent:Ctor(client)
  CSummerActivityEvent.super.Ctor(self, client)
end

function CSummerActivityEvent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.constructionID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.eventID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupID) then
    return false
  end
  return true
end

function CSummerActivityEvent:Unmarshal(buffer)
  local ret = true
  ret, self.constructionID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.eventID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lineupID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSummerActivityEvent
