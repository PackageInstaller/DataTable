-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sweekbossredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SWeekBossRedPoint = dataclass("SWeekBossRedPoint", require("framework.net.protocol"))
SWeekBossRedPoint.ProtocolType = 4142
SWeekBossRedPoint.MaxSize = 65535
SWeekBossRedPoint.redType = 0
SWeekBossRedPoint.UNLOCK_NIGHTMARE = 1
SWeekBossRedPoint.RECEIVE_REWARD = 2
SWeekBossRedPoint.UNLOCK_TALENT = 3
SWeekBossRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SWeekBossRedPoint
  ((SWeekBossRedPoint.super).Ctor)(self, client)
end

SWeekBossRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.redType) then
    return false
  end
  return true
end

SWeekBossRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SWeekBossRedPoint

