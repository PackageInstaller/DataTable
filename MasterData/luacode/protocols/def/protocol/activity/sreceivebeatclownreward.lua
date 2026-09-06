local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveBeatClownReward = dataclass("SReceiveBeatClownReward", require("framework.net.protocol"))
SReceiveBeatClownReward.ProtocolType = 2618
SReceiveBeatClownReward.MaxSize = 65535
SReceiveBeatClownReward.times = 0

function SReceiveBeatClownReward:Ctor(client)
  SReceiveBeatClownReward.super.Ctor(self, client)
end

function SReceiveBeatClownReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.times) then
    return false
  end
  return true
end

function SReceiveBeatClownReward:Unmarshal(buffer)
  local ret = true
  ret, self.times = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveBeatClownReward
