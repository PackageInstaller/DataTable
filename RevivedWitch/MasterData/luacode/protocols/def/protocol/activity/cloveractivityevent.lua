-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cloveractivityevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
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
CLoverActivityEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CLoverActivityEvent
  ((CLoverActivityEvent.super).Ctor)(self, client)
end

CLoverActivityEvent.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.constructionID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.eventID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lineupID) then
    return false
  end
  return true
end

CLoverActivityEvent.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLoverActivityEvent

