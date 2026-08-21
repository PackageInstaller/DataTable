-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cagainstbossgetweeklyawards.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAgainstBossGetWeeklyAwards = dataclass("CAgainstBossGetWeeklyAwards", require("framework.net.protocol"))
CAgainstBossGetWeeklyAwards.ProtocolType = 2671
CAgainstBossGetWeeklyAwards.MaxSize = 65535
CAgainstBossGetWeeklyAwards.weeklyAwardId = 0
CAgainstBossGetWeeklyAwards.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAgainstBossGetWeeklyAwards
  ((CAgainstBossGetWeeklyAwards.super).Ctor)(self, client)
end

CAgainstBossGetWeeklyAwards.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.weeklyAwardId) then
    return false
  end
  return true
end

CAgainstBossGetWeeklyAwards.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAgainstBossGetWeeklyAwards

