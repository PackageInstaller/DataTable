local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SMonthCardDailyReward = dataclass("SMonthCardDailyReward", require("framework.net.protocol"))
SMonthCardDailyReward.ProtocolType = 3602
SMonthCardDailyReward.MaxSize = 65535

function SMonthCardDailyReward:Ctor(client)
  SMonthCardDailyReward.super.Ctor(self, client)
  self.dailyReward = {}
end

function SMonthCardDailyReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.dailyReward)) then
    return false
  end
  for key, value in pairs(self.dailyReward) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SMonthCardDailyReward:Unmarshal(buffer)
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.dailyReward[key] = value
  end
  return ret
end

return SMonthCardDailyReward
