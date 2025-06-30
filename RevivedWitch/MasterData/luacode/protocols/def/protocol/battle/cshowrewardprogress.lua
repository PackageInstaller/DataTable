-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cshowrewardprogress.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CShowRewardProgress = dataclass("CShowRewardProgress", require("framework.net.protocol"))
CShowRewardProgress.ProtocolType = 4113
CShowRewardProgress.MaxSize = 65535
CShowRewardProgress.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CShowRewardProgress
  ((CShowRewardProgress.super).Ctor)(self, client)
end

CShowRewardProgress.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CShowRewardProgress.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CShowRewardProgress

