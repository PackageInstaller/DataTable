local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPreviewPassedPointsReward = dataclass("SPreviewPassedPointsReward", require("framework.net.protocol"))
SPreviewPassedPointsReward.ProtocolType = 2432
SPreviewPassedPointsReward.MaxSize = 65535
SPreviewPassedPointsReward.afterBattle = 0

function SPreviewPassedPointsReward:Ctor(client)
  SPreviewPassedPointsReward.super.Ctor(self, client)
  self.rewards = {}
end

function SPreviewPassedPointsReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.afterBattle) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.rewards)) then
    return false
  end
  for key, value in pairs(self.rewards) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SPreviewPassedPointsReward:Unmarshal(buffer)
  local ret = true
  ret, self.afterBattle = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    value = require("protocols.bean.protocol.activity.passedpointsreward").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.rewards[key] = value
  end
  return ret
end

return SPreviewPassedPointsReward
