local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenChristmasDinner = dataclass("COpenChristmasDinner", require("framework.net.protocol"))
COpenChristmasDinner.ProtocolType = 2530
COpenChristmasDinner.MaxSize = 65536

function COpenChristmasDinner:Ctor(client)
  COpenChristmasDinner.super.Ctor(self, client)
end

function COpenChristmasDinner:Marshal(buffer)
  return true
end

function COpenChristmasDinner:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenChristmasDinner
