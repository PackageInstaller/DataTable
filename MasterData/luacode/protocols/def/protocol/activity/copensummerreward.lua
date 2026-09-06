local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenSummerReward = dataclass("COpenSummerReward", require("framework.net.protocol"))
COpenSummerReward.ProtocolType = 2719
COpenSummerReward.MaxSize = 65535

function COpenSummerReward:Ctor(client)
  COpenSummerReward.super.Ctor(self, client)
end

function COpenSummerReward:Marshal(buffer)
  return true
end

function COpenSummerReward:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenSummerReward
