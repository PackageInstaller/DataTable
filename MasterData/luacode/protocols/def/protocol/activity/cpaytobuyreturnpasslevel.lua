local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CPayToBuyReturnPassLevel = dataclass("CPayToBuyReturnPassLevel", require("framework.net.protocol"))
CPayToBuyReturnPassLevel.ProtocolType = 2742
CPayToBuyReturnPassLevel.MaxSize = 65535

function CPayToBuyReturnPassLevel:Ctor(client)
  CPayToBuyReturnPassLevel.super.Ctor(self, client)
end

function CPayToBuyReturnPassLevel:Marshal(buffer)
  return true
end

function CPayToBuyReturnPassLevel:Unmarshal(buffer)
  local ret = true
  return ret
end

return CPayToBuyReturnPassLevel
