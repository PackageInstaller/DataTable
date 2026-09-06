local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SForbidLogin = dataclass("SForbidLogin", require("framework.net.protocol"))
SForbidLogin.ProtocolType = 1083
SForbidLogin.MaxSize = 65535
SForbidLogin.restTime = 0

function SForbidLogin:Ctor(client)
  SForbidLogin.super.Ctor(self, client)
end

function SForbidLogin:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.restTime) then
    return false
  end
  return true
end

function SForbidLogin:Unmarshal(buffer)
  local ret = true
  ret, self.restTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SForbidLogin
