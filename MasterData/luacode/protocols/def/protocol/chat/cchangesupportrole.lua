local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeSupportRole = dataclass("CChangeSupportRole", require("framework.net.protocol"))
CChangeSupportRole.ProtocolType = 1140
CChangeSupportRole.MaxSize = 65535
CChangeSupportRole.roleId = 0

function CChangeSupportRole:Ctor(client)
  CChangeSupportRole.super.Ctor(self, client)
end

function CChangeSupportRole:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CChangeSupportRole:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeSupportRole
