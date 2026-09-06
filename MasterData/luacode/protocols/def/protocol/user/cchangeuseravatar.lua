local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeUserAvatar = dataclass("CChangeUserAvatar", require("framework.net.protocol"))
CChangeUserAvatar.ProtocolType = 2224
CChangeUserAvatar.MaxSize = 65535
CChangeUserAvatar.avatarId = 0

function CChangeUserAvatar:Ctor(client)
  CChangeUserAvatar.super.Ctor(self, client)
end

function CChangeUserAvatar:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.avatarId) then
    return false
  end
  return true
end

function CChangeUserAvatar:Unmarshal(buffer)
  local ret = true
  ret, self.avatarId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeUserAvatar
