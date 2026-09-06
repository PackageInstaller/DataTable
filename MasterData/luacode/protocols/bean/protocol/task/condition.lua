local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Condition = dataclass("Condition")
Condition.conditionIndex = 0
Condition.value = 0
Condition.destValue = 0

function Condition:Ctor()
end

function Condition:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.conditionIndex) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.value) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.destValue) then
    return false
  end
  return true
end

function Condition:Unmarshal(buffer)
  local ret = true
  ret, self.conditionIndex = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.destValue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return Condition
