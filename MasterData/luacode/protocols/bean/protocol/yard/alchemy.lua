local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Alchemy = dataclass("Alchemy")
Alchemy.id = 0
Alchemy.buildLevel = 0
Alchemy.alchemyLevel = 0
Alchemy.alchemyStage = 0
Alchemy.alchemyExperience = 0
Alchemy.roleId = 0

function Alchemy:Ctor()
end

function Alchemy:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.buildLevel) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.alchemyLevel) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.alchemyStage) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.alchemyExperience) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function Alchemy:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.buildLevel = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.alchemyLevel = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.alchemyStage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.alchemyExperience = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return Alchemy
