local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLogin = dataclass("SLogin", require("framework.net.protocol"))
SLogin.ProtocolType = 102
SLogin.MaxSize = 256
SLogin.userid = 0
SLogin.token = ""
SLogin.needActive = 0
SLogin.serverId = 0

function SLogin:Ctor(client)
  SLogin.super.Ctor(self, client)
end

function SLogin:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.token) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.needActive) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.serverId) then
    return false
  end
  return true
end

function SLogin:Unmarshal(buffer)
  local ret = true
  ret, self.userid = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.token = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.needActive = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.serverId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLogin
