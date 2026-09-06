local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRoleConvertToAvatar = dataclass("SRoleConvertToAvatar", require("framework.net.protocol"))
SRoleConvertToAvatar.ProtocolType = 2264
SRoleConvertToAvatar.MaxSize = 65535
SRoleConvertToAvatar.avatarId = 0

function SRoleConvertToAvatar:Ctor(client)
  SRoleConvertToAvatar.super.Ctor(self, client)
end

function SRoleConvertToAvatar:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.avatarId) then
    return false
  end
  return true
end

function SRoleConvertToAvatar:Unmarshal(buffer)
  local ret = true
  ret, self.avatarId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRoleConvertToAvatar
