-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sweekbosstime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SWeekBossTime = dataclass("SWeekBossTime", require("framework.net.protocol"))
SWeekBossTime.ProtocolType = 4147
SWeekBossTime.MaxSize = 65535
SWeekBossTime.leftTime = 0
SWeekBossTime.resetTime = 0
SWeekBossTime.nightmareTime = 0
SWeekBossTime.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SWeekBossTime
  ((SWeekBossTime.super).Ctor)(self, client)
end

SWeekBossTime.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.resetTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.nightmareTime) then
    return false
  end
  return true
end

SWeekBossTime.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SWeekBossTime

