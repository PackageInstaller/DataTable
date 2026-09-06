local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRougeTowerUpdateUnreceivedReward = dataclass("CRougeTowerUpdateUnreceivedReward", require("framework.net.protocol"))
CRougeTowerUpdateUnreceivedReward.ProtocolType = 2755
CRougeTowerUpdateUnreceivedReward.MaxSize = 65535

function CRougeTowerUpdateUnreceivedReward:Ctor(client)
  CRougeTowerUpdateUnreceivedReward.super.Ctor(self, client)
end

function CRougeTowerUpdateUnreceivedReward:Marshal(buffer)
  return true
end

function CRougeTowerUpdateUnreceivedReward:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRougeTowerUpdateUnreceivedReward
