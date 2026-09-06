local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReturnOtherUser = dataclass("SReturnOtherUser", require("framework.net.protocol"))
SReturnOtherUser.ProtocolType = 1134
SReturnOtherUser.MaxSize = 65535
SReturnOtherUser.userId = 0

function SReturnOtherUser:Ctor(client)
  SReturnOtherUser.super.Ctor(self, client)
end

function SReturnOtherUser:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function SReturnOtherUser:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReturnOtherUser
