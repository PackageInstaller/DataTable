local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SMonthlySignInfo = dataclass("SMonthlySignInfo", require("framework.net.protocol"))
SMonthlySignInfo.ProtocolType = 2677
SMonthlySignInfo.MaxSize = 65535
SMonthlySignInfo.month = 0
SMonthlySignInfo.days = 0
SMonthlySignInfo.complementNum = 0

function SMonthlySignInfo:Ctor(client)
  SMonthlySignInfo.super.Ctor(self, client)
  self.receivedAward = {}
  self.monthDay = {}
end

function SMonthlySignInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.month) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.days) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.complementNum) then
    return false
  end
  local length = table.slen(self.receivedAward)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.receivedAward[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.monthDay)) then
    return false
  end
  for key, value in pairs(self.monthDay) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SMonthlySignInfo:Unmarshal(buffer)
  local ret = true
  ret, self.month = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.days = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.complementNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.receivedAward[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
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
    self.monthDay[key] = value
  end
  return ret
end

return SMonthlySignInfo
