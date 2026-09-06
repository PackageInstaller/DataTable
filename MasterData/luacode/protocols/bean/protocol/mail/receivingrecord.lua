local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ReceivingRecord = dataclass("ReceivingRecord")
ReceivingRecord.receivingTime = 0

function ReceivingRecord:Ctor()
  self.awards = {}
end

function ReceivingRecord:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.receivingTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.awards)) then
    return false
  end
  for key, value in pairs(self.awards) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function ReceivingRecord:Unmarshal(buffer)
  local ret = true
  ret, self.receivingTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
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
    self.awards[key] = value
  end
  return ret
end

return ReceivingRecord
