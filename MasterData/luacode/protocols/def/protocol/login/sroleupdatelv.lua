local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRoleUpdateLv = dataclass("SRoleUpdateLv", require("framework.net.protocol"))
SRoleUpdateLv.ProtocolType = 1016
SRoleUpdateLv.MaxSize = 65535
SRoleUpdateLv.roleId = 0
SRoleUpdateLv.level = 0
SRoleUpdateLv.exp = 0

function SRoleUpdateLv:Ctor(client)
  SRoleUpdateLv.super.Ctor(self, client)
end

function SRoleUpdateLv:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.level) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.exp) then
    return false
  end
  return true
end

function SRoleUpdateLv:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  ret, self.exp = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRoleUpdateLv
