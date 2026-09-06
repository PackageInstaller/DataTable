local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Status = dataclass("Status")
Status.leftHp = 0
Status.monsterId = 0
Status.skillId = 0

function Status:Ctor()
end

function Status:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftHp) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.monsterId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skillId) then
    return false
  end
  return true
end

function Status:Unmarshal(buffer)
  local ret = true
  ret, self.leftHp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.monsterId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.skillId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return Status
