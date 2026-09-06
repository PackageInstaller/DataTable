local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveShopPointReward = dataclass("CReceiveShopPointReward", require("framework.net.protocol"))
CReceiveShopPointReward.ProtocolType = 3411
CReceiveShopPointReward.MaxSize = 65535
CReceiveShopPointReward.id = 0

function CReceiveShopPointReward:Ctor(client)
  CReceiveShopPointReward.super.Ctor(self, client)
end

function CReceiveShopPointReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  return true
end

function CReceiveShopPointReward:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveShopPointReward
