local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenBackInvite = dataclass("COpenBackInvite", require("framework.net.protocol"))
COpenBackInvite.ProtocolType = 2549
COpenBackInvite.MaxSize = 65535

function COpenBackInvite:Ctor(client)
  COpenBackInvite.super.Ctor(self, client)
end

function COpenBackInvite:Marshal(buffer)
  return true
end

function COpenBackInvite:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenBackInvite
