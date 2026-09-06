local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFirstChargeGetReward = dataclass("CFirstChargeGetReward", require("framework.net.protocol"))
CFirstChargeGetReward.ProtocolType = 2768
CFirstChargeGetReward.MaxSize = 65535
CFirstChargeGetReward.id = 0

function CFirstChargeGetReward:Ctor(client)
  CFirstChargeGetReward.super.Ctor(self, client)
end

function CFirstChargeGetReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CFirstChargeGetReward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFirstChargeGetReward
