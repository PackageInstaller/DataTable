local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CShowRewardProgress = dataclass("CShowRewardProgress", require("framework.net.protocol"))
CShowRewardProgress.ProtocolType = 4113
CShowRewardProgress.MaxSize = 65535

function CShowRewardProgress:Ctor(client)
  CShowRewardProgress.super.Ctor(self, client)
end

function CShowRewardProgress:Marshal(buffer)
  return true
end

function CShowRewardProgress:Unmarshal(buffer)
  local ret = true
  return ret
end

return CShowRewardProgress
