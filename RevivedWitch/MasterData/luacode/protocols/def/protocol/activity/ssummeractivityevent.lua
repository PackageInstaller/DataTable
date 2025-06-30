-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssummeractivityevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSummerActivityEvent = dataclass("SSummerActivityEvent", require("framework.net.protocol"))
SSummerActivityEvent.ProtocolType = 2501
SSummerActivityEvent.MaxSize = 65535
SSummerActivityEvent.result = 0
SSummerActivityEvent.constructionID = 0
SSummerActivityEvent.eventID = 0
SSummerActivityEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSummerActivityEvent
  ((SSummerActivityEvent.super).Ctor)(self, client)
end

SSummerActivityEvent.Marshal = function(self, buffer)
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

SSummerActivityEvent.Unmarshal = function(self, buffer)
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

return SSummerActivityEvent

