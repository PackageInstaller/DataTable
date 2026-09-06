local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSummerEchoEvent = dataclass("CSummerEchoEvent", require("framework.net.protocol"))
CSummerEchoEvent.ProtocolType = 2706
CSummerEchoEvent.MaxSize = 65535
CSummerEchoEvent.constructionID = 0
CSummerEchoEvent.eventID = 0
CSummerEchoEvent.lineupID = 0
CSummerEchoEvent.MAINLINE_DRAMA = 1
CSummerEchoEvent.MAINLINE_BATTLE = 2
CSummerEchoEvent.FREEDOM_BATTLE = 3
CSummerEchoEvent.SHOP = 4
CSummerEchoEvent.CHALLENGE_MODE = 6

function CSummerEchoEvent:Ctor(client)
  CSummerEchoEvent.super.Ctor(self, client)
end

function CSummerEchoEvent:Marshal(buffer)
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

function CSummerEchoEvent:Unmarshal(buffer)
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

return CSummerEchoEvent
