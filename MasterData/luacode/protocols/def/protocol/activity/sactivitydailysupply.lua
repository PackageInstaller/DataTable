local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SActivityDailySupply = dataclass("SActivityDailySupply", require("framework.net.protocol"))
SActivityDailySupply.ProtocolType = 2701
SActivityDailySupply.MaxSize = 65535
SActivityDailySupply.activityId = 0
SActivityDailySupply.LOCKED = 0
SActivityDailySupply.UNLOCKED = 1
SActivityDailySupply.FETCHED = 2

function SActivityDailySupply:Ctor(client)
  SActivityDailySupply.super.Ctor(self, client)
  self.supply = {}
end

function SActivityDailySupply:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.supply)) then
    return false
  end
  for key, value in pairs(self.supply) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SActivityDailySupply:Unmarshal(buffer)
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
    self.supply[key] = value
  end
  return ret
end

return SActivityDailySupply
