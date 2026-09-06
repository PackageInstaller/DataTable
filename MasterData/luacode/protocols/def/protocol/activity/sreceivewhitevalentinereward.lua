local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveWhiteValentineReward = dataclass("SReceiveWhiteValentineReward", require("framework.net.protocol"))
SReceiveWhiteValentineReward.ProtocolType = 2614
SReceiveWhiteValentineReward.MaxSize = 65535
SReceiveWhiteValentineReward.id = 0

function SReceiveWhiteValentineReward:Ctor(client)
  SReceiveWhiteValentineReward.super.Ctor(self, client)
end

function SReceiveWhiteValentineReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function SReceiveWhiteValentineReward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveWhiteValentineReward
