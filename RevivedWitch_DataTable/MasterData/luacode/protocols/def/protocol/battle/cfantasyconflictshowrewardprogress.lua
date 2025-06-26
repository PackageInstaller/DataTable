-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cfantasyconflictshowrewardprogress.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFantasyConflictShowRewardProgress = dataclass("CFantasyConflictShowRewardProgress", require("framework.net.protocol"))
CFantasyConflictShowRewardProgress.ProtocolType = 4151
CFantasyConflictShowRewardProgress.MaxSize = 65535
CFantasyConflictShowRewardProgress.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFantasyConflictShowRewardProgress
  ((CFantasyConflictShowRewardProgress.super).Ctor)(self, client)
end

CFantasyConflictShowRewardProgress.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CFantasyConflictShowRewardProgress.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CFantasyConflictShowRewardProgress

