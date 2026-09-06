local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRoleQuickLevelUP = dataclass("CRoleQuickLevelUP", require("framework.net.protocol"))
CRoleQuickLevelUP.ProtocolType = 1089
CRoleQuickLevelUP.MaxSize = 65535
CRoleQuickLevelUP.WaitProtocol = "protocol.notify.scancelloading"
CRoleQuickLevelUP.roleId = 0
CRoleQuickLevelUP.level = 0

function CRoleQuickLevelUP:Ctor(client)
  CRoleQuickLevelUP.super.Ctor(self, client)
end

function CRoleQuickLevelUP:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  return true
end

function CRoleQuickLevelUP:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRoleQuickLevelUP
