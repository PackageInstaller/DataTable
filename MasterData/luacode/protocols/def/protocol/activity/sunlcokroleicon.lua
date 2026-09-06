local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUnlcokRoleIcon = dataclass("SUnlcokRoleIcon", require("framework.net.protocol"))
SUnlcokRoleIcon.ProtocolType = 2595
SUnlcokRoleIcon.MaxSize = 65535
SUnlcokRoleIcon.roleId = 0
SUnlcokRoleIcon.roleNum = 0

function SUnlcokRoleIcon:Ctor(client)
  SUnlcokRoleIcon.super.Ctor(self, client)
end

function SUnlcokRoleIcon:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleNum) then
    return false
  end
  return true
end

function SUnlcokRoleIcon:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUnlcokRoleIcon
