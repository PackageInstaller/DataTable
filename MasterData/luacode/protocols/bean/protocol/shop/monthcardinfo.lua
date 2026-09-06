local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local MonthCardInfo = dataclass("MonthCardInfo")
MonthCardInfo.remainTime = 0
MonthCardInfo.endTime = ""

function MonthCardInfo:Ctor()
end

function MonthCardInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.remainTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.endTime) then
    return false
  end
  return true
end

function MonthCardInfo:Unmarshal(buffer)
  local ret = true
  ret, self.remainTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.endTime = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return MonthCardInfo
