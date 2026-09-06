local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CPreviewPassedPointsReward = dataclass("CPreviewPassedPointsReward", require("framework.net.protocol"))
CPreviewPassedPointsReward.ProtocolType = 2431
CPreviewPassedPointsReward.MaxSize = 65535

function CPreviewPassedPointsReward:Ctor(client)
  CPreviewPassedPointsReward.super.Ctor(self, client)
end

function CPreviewPassedPointsReward:Marshal(buffer)
  return true
end

function CPreviewPassedPointsReward:Unmarshal(buffer)
  local ret = true
  return ret
end

return CPreviewPassedPointsReward
