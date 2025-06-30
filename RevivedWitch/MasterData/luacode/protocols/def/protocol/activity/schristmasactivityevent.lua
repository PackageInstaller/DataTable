-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/schristmasactivityevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChristmasActivityEvent = dataclass("SChristmasActivityEvent", require("framework.net.protocol"))
SChristmasActivityEvent.ProtocolType = 2529
SChristmasActivityEvent.MaxSize = 65535
SChristmasActivityEvent.result = 0
SChristmasActivityEvent.constructionID = 0
SChristmasActivityEvent.eventID = 0
SChristmasActivityEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChristmasActivityEvent
  ((SChristmasActivityEvent.super).Ctor)(self, client)
end

SChristmasActivityEvent.Marshal = function(self, buffer)
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

SChristmasActivityEvent.Unmarshal = function(self, buffer)
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

return SChristmasActivityEvent

