local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveShopPointReward = dataclass("SReceiveShopPointReward", require("framework.net.protocol"))
SReceiveShopPointReward.ProtocolType = 3412
SReceiveShopPointReward.MaxSize = 65535
SReceiveShopPointReward.id = 0

function SReceiveShopPointReward:Ctor(client)
  SReceiveShopPointReward.super.Ctor(self, client)
end

function SReceiveShopPointReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function SReceiveShopPointReward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveShopPointReward
