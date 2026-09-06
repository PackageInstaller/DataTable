local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChristmasActivityEvent = dataclass("CChristmasActivityEvent", require("framework.net.protocol"))
CChristmasActivityEvent.ProtocolType = 2528
CChristmasActivityEvent.MaxSize = 65535
CChristmasActivityEvent.constructionID = 0
CChristmasActivityEvent.eventID = 0
CChristmasActivityEvent.lineupID = 0
CChristmasActivityEvent.MAINLINE_BATTLE = 1
CChristmasActivityEvent.MAINLINE_PLOT = 2
CChristmasActivityEvent.BRANCH_PLOT = 3
CChristmasActivityEvent.COMMON_BATTLE = 4
CChristmasActivityEvent.CHRISTMAS_DINNER = 5
CChristmasActivityEvent.TOP_LEVEL = 6
CChristmasActivityEvent.PACKAGE = 7
CChristmasActivityEvent.SHOP = 8
CChristmasActivityEvent.DAILY_MAIL = 9
CChristmasActivityEvent.COMMON_TOWER = 10
CChristmasActivityEvent.COMMON_BOSS = 11
CChristmasActivityEvent.RANKING_BOSS = 12
CChristmasActivityEvent.END_PLOT = 13
CChristmasActivityEvent.PLOT_REVIEW = 14

function CChristmasActivityEvent:Ctor(client)
  CChristmasActivityEvent.super.Ctor(self, client)
end

function CChristmasActivityEvent:Marshal(buffer)
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

function CChristmasActivityEvent:Unmarshal(buffer)
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

return CChristmasActivityEvent
