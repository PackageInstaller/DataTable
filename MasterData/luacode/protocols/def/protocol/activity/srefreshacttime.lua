local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshActTime = dataclass("SRefreshActTime", require("framework.net.protocol"))
SRefreshActTime.ProtocolType = 2562
SRefreshActTime.MaxSize = 65535
SRefreshActTime.activityId = 0
SRefreshActTime.leftTime = 0

function SRefreshActTime:Ctor(client)
  SRefreshActTime.super.Ctor(self, client)
end

function SRefreshActTime:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  return true
end

function SRefreshActTime:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshActTime
