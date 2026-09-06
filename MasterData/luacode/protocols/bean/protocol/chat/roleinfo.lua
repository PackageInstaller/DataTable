local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local RoleInfo = dataclass("RoleInfo")
RoleInfo.roleId = 0
RoleInfo.roleLv = 0
RoleInfo.breakLv = 0
RoleInfo.skin = 0

function RoleInfo:Ctor()
end

function RoleInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleLv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.breakLv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skin) then
    return false
  end
  return true
end

function RoleInfo:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleLv = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.breakLv = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.skin = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return RoleInfo
