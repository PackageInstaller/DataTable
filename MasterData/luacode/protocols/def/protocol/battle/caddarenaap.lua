local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAddArenaAP = dataclass("CAddArenaAP", require("framework.net.protocol"))
CAddArenaAP.ProtocolType = 4118
CAddArenaAP.MaxSize = 65535

function CAddArenaAP:Ctor(client)
  CAddArenaAP.super.Ctor(self, client)
end

function CAddArenaAP:Marshal(buffer)
  return true
end

function CAddArenaAP:Unmarshal(buffer)
  local ret = true
  return ret
end

return CAddArenaAP
