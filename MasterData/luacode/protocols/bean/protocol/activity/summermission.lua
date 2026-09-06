local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SummerMission = dataclass("SummerMission")
SummerMission.ID = 0
SummerMission.value = 0
SummerMission.isFinish = 0

function SummerMission:Ctor()
end

function SummerMission:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.ID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.value) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.isFinish) then
    return false
  end
  return true
end

function SummerMission:Unmarshal(buffer)
  local ret = true
  ret, self.ID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.isFinish = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SummerMission
