local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRoleBreak = dataclass("CRoleBreak", require("framework.net.protocol"))
CRoleBreak.ProtocolType = 1024
CRoleBreak.MaxSize = 65535
CRoleBreak.WaitProtocol = "protocol.notify.scancelloading"
CRoleBreak.roleId = 0

function CRoleBreak:Ctor(client)
  CRoleBreak.super.Ctor(self, client)
end

function CRoleBreak:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CRoleBreak:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRoleBreak
