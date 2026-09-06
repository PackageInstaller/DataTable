local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CEraseNewRoleRedDot = dataclass("CEraseNewRoleRedDot", require("framework.net.protocol"))
CEraseNewRoleRedDot.ProtocolType = 1079
CEraseNewRoleRedDot.MaxSize = 65535
CEraseNewRoleRedDot.roleId = 0

function CEraseNewRoleRedDot:Ctor(client)
  CEraseNewRoleRedDot.super.Ctor(self, client)
end

function CEraseNewRoleRedDot:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CEraseNewRoleRedDot:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CEraseNewRoleRedDot
