local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveWhiteValentineReward = dataclass("CReceiveWhiteValentineReward", require("framework.net.protocol"))
CReceiveWhiteValentineReward.ProtocolType = 2613
CReceiveWhiteValentineReward.MaxSize = 65535
CReceiveWhiteValentineReward.id = 0

function CReceiveWhiteValentineReward:Ctor(client)
  CReceiveWhiteValentineReward.super.Ctor(self, client)
end

function CReceiveWhiteValentineReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CReceiveWhiteValentineReward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveWhiteValentineReward
