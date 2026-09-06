local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local WeeklyAwards = dataclass("WeeklyAwards")
WeeklyAwards.id = 0
WeeklyAwards.awardStatus = 0

function WeeklyAwards:Ctor()
end

function WeeklyAwards:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.awardStatus) then
    return false
  end
  return true
end

function WeeklyAwards:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.awardStatus = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return WeeklyAwards
