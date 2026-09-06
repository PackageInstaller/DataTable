local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveWatermelonReward = dataclass("CReceiveWatermelonReward", require("framework.net.protocol"))
CReceiveWatermelonReward.ProtocolType = 3513
CReceiveWatermelonReward.MaxSize = 65535
CReceiveWatermelonReward.id = 0

function CReceiveWatermelonReward:Ctor(client)
  CReceiveWatermelonReward.super.Ctor(self, client)
end

function CReceiveWatermelonReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CReceiveWatermelonReward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveWatermelonReward
