local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local TriggerObject = dataclass("TriggerObject")
TriggerObject.kind = 0
TriggerObject.value = 0

function TriggerObject:Ctor()
end

function TriggerObject:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.kind) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.value) then
    return false
  end
  return true
end

function TriggerObject:Unmarshal(buffer)
  local ret = true
  ret, self.kind = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return TriggerObject
