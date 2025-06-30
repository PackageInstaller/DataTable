-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/csummeractivityevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
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
CSummerActivityEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSummerActivityEvent
  ((CSummerActivityEvent.super).Ctor)(self, client)
end

CSummerActivityEvent.Marshal = function(self, buffer)
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

CSummerActivityEvent.Unmarshal = function(self, buffer)
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

return CSummerActivityEvent

