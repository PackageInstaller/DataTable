local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRune = dataclass("CRune", require("framework.net.protocol"))
CRune.ProtocolType = 3702
CRune.MaxSize = 65535

function CRune:Ctor(client)
  CRune.super.Ctor(self, client)
end

function CRune:Marshal(buffer)
  return true
end

function CRune:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRune
