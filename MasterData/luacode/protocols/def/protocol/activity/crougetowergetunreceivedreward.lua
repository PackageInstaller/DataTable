local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRougeTowerGetUnreceivedReward = dataclass("CRougeTowerGetUnreceivedReward", require("framework.net.protocol"))
CRougeTowerGetUnreceivedReward.ProtocolType = 2757
CRougeTowerGetUnreceivedReward.MaxSize = 65535

function CRougeTowerGetUnreceivedReward:Ctor(client)
  CRougeTowerGetUnreceivedReward.super.Ctor(self, client)
end

function CRougeTowerGetUnreceivedReward:Marshal(buffer)
  return true
end

function CRougeTowerGetUnreceivedReward:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRougeTowerGetUnreceivedReward
