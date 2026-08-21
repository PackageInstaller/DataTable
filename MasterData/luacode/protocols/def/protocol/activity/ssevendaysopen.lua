-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssevendaysopen.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSevenDaysOpen = dataclass("SSevenDaysOpen", require("framework.net.protocol"))
SSevenDaysOpen.ProtocolType = 2435
SSevenDaysOpen.MaxSize = 65535
SSevenDaysOpen.remainTime = 0
SSevenDaysOpen.version = 0
SSevenDaysOpen.OLD_VERSION = 1
SSevenDaysOpen.NEW_VERSION = 2
SSevenDaysOpen.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSevenDaysOpen
  ((SSevenDaysOpen.super).Ctor)(self, client)
end

SSevenDaysOpen.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.remainTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.version) then
    return false
  end
  return true
end

SSevenDaysOpen.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSevenDaysOpen

