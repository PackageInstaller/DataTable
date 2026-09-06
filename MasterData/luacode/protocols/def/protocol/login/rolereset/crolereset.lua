local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRoleReset = dataclass("CRoleReset", require("framework.net.protocol"))
CRoleReset.ProtocolType = 1087
CRoleReset.MaxSize = 65535
CRoleReset.roleId = 0
CRoleReset.isPreview = 0

function CRoleReset:Ctor(client)
  CRoleReset.super.Ctor(self, client)
end

function CRoleReset:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.isPreview) then
    return false
  end
  return true
end

function CRoleReset:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.isPreview = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRoleReset
