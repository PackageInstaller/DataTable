local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeSupportRole = dataclass("SChangeSupportRole", require("framework.net.protocol"))
SChangeSupportRole.ProtocolType = 1142
SChangeSupportRole.MaxSize = 65535
SChangeSupportRole.roleIds = 0

function SChangeSupportRole:Ctor(client)
  SChangeSupportRole.super.Ctor(self, client)
end

function SChangeSupportRole:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleIds) then
    return false
  end
  return true
end

function SChangeSupportRole:Unmarshal(buffer)
  local ret = true
  ret, self.roleIds = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeSupportRole
