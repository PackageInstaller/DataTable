-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/csummerechoevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
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
CSummerEchoEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSummerEchoEvent
  ((CSummerEchoEvent.super).Ctor)(self, client)
end

CSummerEchoEvent.Marshal = function(self, buffer)
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

CSummerEchoEvent.Unmarshal = function(self, buffer)
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

return CSummerEchoEvent

