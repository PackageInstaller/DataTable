local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRefreshCardUI = dataclass("CRefreshCardUI", require("framework.net.protocol"))
CRefreshCardUI.ProtocolType = 1501
CRefreshCardUI.MaxSize = 65535

function CRefreshCardUI:Ctor(client)
  CRefreshCardUI.super.Ctor(self, client)
end

function CRefreshCardUI:Marshal(buffer)
  return true
end

function CRefreshCardUI:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRefreshCardUI
