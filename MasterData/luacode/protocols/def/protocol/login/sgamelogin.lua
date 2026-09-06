local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGameLogin = dataclass("SGameLogin", require("framework.net.protocol"))
SGameLogin.ProtocolType = 1082
SGameLogin.MaxSize = 65535

function SGameLogin:Ctor(client)
  SGameLogin.super.Ctor(self, client)
end

function SGameLogin:Marshal(buffer)
  return true
end

function SGameLogin:Unmarshal(buffer)
  local ret = true
  return ret
end

return SGameLogin
