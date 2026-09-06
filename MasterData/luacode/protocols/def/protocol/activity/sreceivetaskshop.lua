local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveTaskShop = dataclass("SReceiveTaskShop", require("framework.net.protocol"))
SReceiveTaskShop.ProtocolType = 2700
SReceiveTaskShop.MaxSize = 65535
SReceiveTaskShop.activityId = 0
SReceiveTaskShop.rewardID = 0

function SReceiveTaskShop:Ctor(client)
  SReceiveTaskShop.super.Ctor(self, client)
end

function SReceiveTaskShop:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardID) then
    return false
  end
  return true
end

function SReceiveTaskShop:Unmarshal(buffer)
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

return SReceiveTaskShop
