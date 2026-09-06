local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SClearRewardInfo = dataclass("SClearRewardInfo", require("framework.net.protocol"))
SClearRewardInfo.ProtocolType = 2726
SClearRewardInfo.MaxSize = 65535
SClearRewardInfo.activityId = 0
SClearRewardInfo.status = 0
SClearRewardInfo.leftTime = 0

function SClearRewardInfo:Ctor(client)
  SClearRewardInfo.super.Ctor(self, client)
end

function SClearRewardInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  return true
end

function SClearRewardInfo:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SClearRewardInfo
