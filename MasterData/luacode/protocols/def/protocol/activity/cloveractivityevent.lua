local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CLoverActivityEvent = dataclass("CLoverActivityEvent", require("framework.net.protocol"))
CLoverActivityEvent.ProtocolType = 2591
CLoverActivityEvent.MaxSize = 65535
CLoverActivityEvent.constructionID = 0
CLoverActivityEvent.eventID = 0
CLoverActivityEvent.lineupID = 0
CLoverActivityEvent.MAINLINE_BATTLE = 1
CLoverActivityEvent.MAINLINE_PLOT = 2
CLoverActivityEvent.ITEM_SHOP = 3
CLoverActivityEvent.COMMON_BATTLE = 4
CLoverActivityEvent.CHOCOLATE = 5
CLoverActivityEvent.FLOWER_LIST = 6
CLoverActivityEvent.DIALOGUE_STORE = 7

function CLoverActivityEvent:Ctor(client)
  CLoverActivityEvent.super.Ctor(self, client)
end

function CLoverActivityEvent:Marshal(buffer)
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

function CLoverActivityEvent:Unmarshal(buffer)
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

return CLoverActivityEvent
