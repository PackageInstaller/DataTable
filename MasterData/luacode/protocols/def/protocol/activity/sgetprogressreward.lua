local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetProgressReward = dataclass("SGetProgressReward", require("framework.net.protocol"))
SGetProgressReward.ProtocolType = 2498
SGetProgressReward.MaxSize = 65535
SGetProgressReward.activityId = 0

function SGetProgressReward:Ctor(client)
  SGetProgressReward.super.Ctor(self, client)
  self.progressReward = {}
end

function SGetProgressReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.progressReward)) then
    return false
  end
  for key, value in pairs(self.progressReward) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SGetProgressReward:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.progressReward[key] = value
  end
  return ret
end

return SGetProgressReward
