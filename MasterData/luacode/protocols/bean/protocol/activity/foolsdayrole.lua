local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local FoolsDayRole = dataclass("FoolsDayRole")
FoolsDayRole.Id = 0
FoolsDayRole.roleLv = 0
FoolsDayRole.weaponLv = 0
FoolsDayRole.attack = 0
FoolsDayRole.blood = 0

function FoolsDayRole:Ctor()
end

function FoolsDayRole:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.Id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleLv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.weaponLv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.attack) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.blood) then
    return false
  end
  return true
end

function FoolsDayRole:Unmarshal(buffer)
  local ret = true
  ret, self.Id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleLv = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.weaponLv = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.attack = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.blood = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return FoolsDayRole
