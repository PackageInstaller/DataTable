-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cweekbosstalent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CWeekBossTalent = dataclass("CWeekBossTalent", require("framework.net.protocol"))
CWeekBossTalent.ProtocolType = 4143
CWeekBossTalent.MaxSize = 65535
CWeekBossTalent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CWeekBossTalent
  ((CWeekBossTalent.super).Ctor)(self, client)
end

CWeekBossTalent.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CWeekBossTalent.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CWeekBossTalent

