local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CPayToBuyAgCoinLevel = dataclass("CPayToBuyAgCoinLevel", require("framework.net.protocol"))
CPayToBuyAgCoinLevel.ProtocolType = 2441
CPayToBuyAgCoinLevel.MaxSize = 65535

function CPayToBuyAgCoinLevel:Ctor(client)
  CPayToBuyAgCoinLevel.super.Ctor(self, client)
end

function CPayToBuyAgCoinLevel:Marshal(buffer)
  return true
end

function CPayToBuyAgCoinLevel:Unmarshal(buffer)
  local ret = true
  return ret
end

return CPayToBuyAgCoinLevel
