local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveTaskShop = dataclass("CReceiveTaskShop", require("framework.net.protocol"))
CReceiveTaskShop.ProtocolType = 2699
CReceiveTaskShop.MaxSize = 65535
CReceiveTaskShop.activityId = 0
CReceiveTaskShop.rewardID = 0

function CReceiveTaskShop:Ctor(client)
  CReceiveTaskShop.super.Ctor(self, client)
end

function CReceiveTaskShop:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardID) then
    return false
  end
  return true
end

function CReceiveTaskShop:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.rewardID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveTaskShop
