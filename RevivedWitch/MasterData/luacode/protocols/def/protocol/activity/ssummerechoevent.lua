-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssummerechoevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSummerEchoEvent = dataclass("SSummerEchoEvent", require("framework.net.protocol"))
SSummerEchoEvent.ProtocolType = 2707
SSummerEchoEvent.MaxSize = 65535
SSummerEchoEvent.result = 0
SSummerEchoEvent.constructionID = 0
SSummerEchoEvent.eventID = 0
SSummerEchoEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSummerEchoEvent
  ((SSummerEchoEvent.super).Ctor)(self, client)
end

SSummerEchoEvent.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.constructionID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.eventID) then
    return false
  end
  return true
end

SSummerEchoEvent.Unmarshal = function(self, buffer)
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

return SSummerEchoEvent

