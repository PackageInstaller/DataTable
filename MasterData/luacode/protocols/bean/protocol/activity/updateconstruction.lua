local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local updateConstruction = dataclass("updateConstruction")
updateConstruction.construction = 0
updateConstruction.canlvup = 0
updateConstruction.unlockEvent = 0

function updateConstruction:Ctor()
end

function updateConstruction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.construction) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.canlvup) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.unlockEvent) then
    return false
  end
  return true
end

function updateConstruction:Unmarshal(buffer)
  local ret = true
  ret, self.construction = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.canlvup = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.unlockEvent = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return updateConstruction
