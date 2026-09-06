local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenBackPack = dataclass("COpenBackPack", require("framework.net.protocol"))
COpenBackPack.ProtocolType = 2555
COpenBackPack.MaxSize = 65535

function COpenBackPack:Ctor(client)
  COpenBackPack.super.Ctor(self, client)
end

function COpenBackPack:Marshal(buffer)
  return true
end

function COpenBackPack:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenBackPack
