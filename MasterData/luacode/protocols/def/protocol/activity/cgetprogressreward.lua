local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetProgressReward = dataclass("CGetProgressReward", require("framework.net.protocol"))
CGetProgressReward.ProtocolType = 2497
CGetProgressReward.MaxSize = 65535
CGetProgressReward.activityId = 0
CGetProgressReward.boxId = 0

function CGetProgressReward:Ctor(client)
  CGetProgressReward.super.Ctor(self, client)
end

function CGetProgressReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.boxId) then
    return false
  end
  return true
end

function CGetProgressReward:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.boxId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetProgressReward
