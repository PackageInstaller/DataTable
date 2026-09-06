local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local PassedPointsReward = dataclass("PassedPointsReward")
PassedPointsReward.passedPointsSum = 0
PassedPointsReward.received = 0

function PassedPointsReward:Ctor()
end

function PassedPointsReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.passedPointsSum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.received) then
    return false
  end
  return true
end

function PassedPointsReward:Unmarshal(buffer)
  local ret = true
  ret, self.passedPointsSum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.received = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return PassedPointsReward
