local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUnlcokRoleIcon = dataclass("CUnlcokRoleIcon", require("framework.net.protocol"))
CUnlcokRoleIcon.ProtocolType = 2594
CUnlcokRoleIcon.MaxSize = 65535
CUnlcokRoleIcon.roleId = 0

function CUnlcokRoleIcon:Ctor(client)
  CUnlcokRoleIcon.super.Ctor(self, client)
end

function CUnlcokRoleIcon:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CUnlcokRoleIcon:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUnlcokRoleIcon
