local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFantasyConflictShowRewardProgress = dataclass("CFantasyConflictShowRewardProgress", require("framework.net.protocol"))
CFantasyConflictShowRewardProgress.ProtocolType = 4151
CFantasyConflictShowRewardProgress.MaxSize = 65535

function CFantasyConflictShowRewardProgress:Ctor(client)
  CFantasyConflictShowRewardProgress.super.Ctor(self, client)
end

function CFantasyConflictShowRewardProgress:Marshal(buffer)
  return true
end

function CFantasyConflictShowRewardProgress:Unmarshal(buffer)
  local ret = true
  return ret
end

return CFantasyConflictShowRewardProgress
