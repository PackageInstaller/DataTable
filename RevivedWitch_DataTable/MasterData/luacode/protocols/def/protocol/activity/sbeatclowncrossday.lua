-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sbeatclowncrossday.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBeatClownCrossDay = dataclass("SBeatClownCrossDay", require("framework.net.protocol"))
SBeatClownCrossDay.ProtocolType = 2622
SBeatClownCrossDay.MaxSize = 65535
SBeatClownCrossDay.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBeatClownCrossDay
  ((SBeatClownCrossDay.super).Ctor)(self, client)
end

SBeatClownCrossDay.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SBeatClownCrossDay.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SBeatClownCrossDay

