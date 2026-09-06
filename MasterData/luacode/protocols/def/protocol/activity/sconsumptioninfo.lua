local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SConsumptionInfo = dataclass("SConsumptionInfo", require("framework.net.protocol"))
SConsumptionInfo.ProtocolType = 2732
SConsumptionInfo.MaxSize = 65535
SConsumptionInfo.activityId = 0
SConsumptionInfo.consumption = 0

function SConsumptionInfo:Ctor(client)
  SConsumptionInfo.super.Ctor(self, client)
  self.awardStatus = {}
end

function SConsumptionInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.consumption) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.awardStatus)) then
    return false
  end
  for key, value in pairs(self.awardStatus) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SConsumptionInfo:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.consumption = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
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
    value = require("protocols.bean.protocol.activity.consumptionaward").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.awardStatus[key] = value
  end
  return ret
end

return SConsumptionInfo
