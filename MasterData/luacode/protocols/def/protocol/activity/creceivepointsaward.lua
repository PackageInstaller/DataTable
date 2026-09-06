local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceivePointsAward = dataclass("CReceivePointsAward", require("framework.net.protocol"))
CReceivePointsAward.ProtocolType = 2438
CReceivePointsAward.MaxSize = 65535
CReceivePointsAward.activityID = 0
CReceivePointsAward.taskID = 0

function CReceivePointsAward:Ctor(client)
  CReceivePointsAward.super.Ctor(self, client)
end

function CReceivePointsAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskID) then
    return false
  end
  return true
end

function CReceivePointsAward:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.taskID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceivePointsAward
