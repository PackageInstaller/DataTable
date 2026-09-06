local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveBeatClownReward = dataclass("CReceiveBeatClownReward", require("framework.net.protocol"))
CReceiveBeatClownReward.ProtocolType = 2617
CReceiveBeatClownReward.MaxSize = 65535
CReceiveBeatClownReward.times = 0

function CReceiveBeatClownReward:Ctor(client)
  CReceiveBeatClownReward.super.Ctor(self, client)
end

function CReceiveBeatClownReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.times) then
    return false
  end
  return true
end

function CReceiveBeatClownReward:Unmarshal(buffer)
  local ret = true
  ret, self.times = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveBeatClownReward
