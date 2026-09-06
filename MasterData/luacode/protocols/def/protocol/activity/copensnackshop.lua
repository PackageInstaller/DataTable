local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenSnackShop = dataclass("COpenSnackShop", require("framework.net.protocol"))
COpenSnackShop.ProtocolType = 2502
COpenSnackShop.MaxSize = 65535

function COpenSnackShop:Ctor(client)
  COpenSnackShop.super.Ctor(self, client)
end

function COpenSnackShop:Marshal(buffer)
  return true
end

function COpenSnackShop:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenSnackShop
