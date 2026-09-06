local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CResourcePanel = dataclass("CResourcePanel", require("framework.net.protocol"))
CResourcePanel.ProtocolType = 1934
CResourcePanel.MaxSize = 65535

function CResourcePanel:Ctor(client)
  CResourcePanel.super.Ctor(self, client)
end

function CResourcePanel:Marshal(buffer)
  return true
end

function CResourcePanel:Unmarshal(buffer)
  local ret = true
  return ret
end

return CResourcePanel
