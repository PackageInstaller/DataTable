local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SActiveActivities = dataclass("SActiveActivities", require("framework.net.protocol"))
SActiveActivities.ProtocolType = 2443
SActiveActivities.MaxSize = 65535

function SActiveActivities:Ctor(client)
  SActiveActivities.super.Ctor(self, client)
  self.activities = {}
end

function SActiveActivities:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.activities)) then
    return false
  end
  for key, value in pairs(self.activities) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SActiveActivities:Unmarshal(buffer)
  local ret = true
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    value = require("protocols.bean.protocol.activity.activityadsbean").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.activities[key] = value
  end
  return ret
end

return SActiveActivities
