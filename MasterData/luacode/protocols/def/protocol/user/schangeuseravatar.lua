local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeUserAvatar = dataclass("SChangeUserAvatar", require("framework.net.protocol"))
SChangeUserAvatar.ProtocolType = 2225
SChangeUserAvatar.MaxSize = 65535
SChangeUserAvatar.avatarId = 0

function SChangeUserAvatar:Ctor(client)
  SChangeUserAvatar.super.Ctor(self, client)
end

function SChangeUserAvatar:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.avatarId) then
    return false
  end
  return true
end

function SChangeUserAvatar:Unmarshal(buffer)
  local ret = true
  ret, self.avatarId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeUserAvatar
