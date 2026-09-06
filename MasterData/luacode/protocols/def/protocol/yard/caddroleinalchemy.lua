local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAddRoleInAlchemy = dataclass("CAddRoleInAlchemy", require("framework.net.protocol"))
CAddRoleInAlchemy.ProtocolType = 2352
CAddRoleInAlchemy.MaxSize = 65535
CAddRoleInAlchemy.roleId = 0

function CAddRoleInAlchemy:Ctor(client)
  CAddRoleInAlchemy.super.Ctor(self, client)
end

function CAddRoleInAlchemy:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CAddRoleInAlchemy:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAddRoleInAlchemy
