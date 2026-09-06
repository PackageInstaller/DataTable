local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSignCrossDay = dataclass("SSignCrossDay", require("framework.net.protocol"))
SSignCrossDay.ProtocolType = 2609
SSignCrossDay.MaxSize = 65535
SSignCrossDay.activityId = 0

function SSignCrossDay:Ctor(client)
  SSignCrossDay.super.Ctor(self, client)
end

function SSignCrossDay:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  return true
end

function SSignCrossDay:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSignCrossDay
