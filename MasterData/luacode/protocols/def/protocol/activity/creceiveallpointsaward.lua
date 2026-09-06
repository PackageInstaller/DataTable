local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveAllPointsAward = dataclass("CReceiveAllPointsAward", require("framework.net.protocol"))
CReceiveAllPointsAward.ProtocolType = 2439
CReceiveAllPointsAward.MaxSize = 65535
CReceiveAllPointsAward.activityID = 0

function CReceiveAllPointsAward:Ctor(client)
  CReceiveAllPointsAward.super.Ctor(self, client)
end

function CReceiveAllPointsAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  return true
end

function CReceiveAllPointsAward:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveAllPointsAward
