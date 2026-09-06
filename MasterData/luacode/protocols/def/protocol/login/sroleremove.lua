local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRoleRemove = dataclass("SRoleRemove", require("framework.net.protocol"))
SRoleRemove.ProtocolType = 1013
SRoleRemove.MaxSize = 65535
SRoleRemove.roleId = 0

function SRoleRemove:Ctor(client)
  SRoleRemove.super.Ctor(self, client)
end

function SRoleRemove:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function SRoleRemove:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRoleRemove
