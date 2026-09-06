local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local DeadRole = dataclass("DeadRole")
DeadRole.roleId = 0
DeadRole.hurtExtent = 0
DeadRole.repairTime = 0
DeadRole.reviveTime = 0

function DeadRole:Ctor()
end

function DeadRole:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.hurtExtent) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.repairTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.reviveTime) then
    return false
  end
  return true
end

function DeadRole:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.hurtExtent = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.repairTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.reviveTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return DeadRole
