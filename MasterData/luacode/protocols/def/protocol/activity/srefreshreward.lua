local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshReward = dataclass("SRefreshReward", require("framework.net.protocol"))
SRefreshReward.ProtocolType = 2559
SRefreshReward.MaxSize = 65535
SRefreshReward.activityID = 0
SRefreshReward.leftTime = 0

function SRefreshReward:Ctor(client)
  SRefreshReward.super.Ctor(self, client)
  self.goodInfo = require("protocols.bean.protocol.activity.goodinfo").Create()
end

function SRefreshReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not self.goodInfo:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshReward:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  if not self.goodInfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshReward
