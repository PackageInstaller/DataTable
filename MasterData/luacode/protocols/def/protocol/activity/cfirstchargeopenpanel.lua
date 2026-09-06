local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFirstChargeOpenPanel = dataclass("CFirstChargeOpenPanel", require("framework.net.protocol"))
CFirstChargeOpenPanel.ProtocolType = 2766
CFirstChargeOpenPanel.MaxSize = 65535

function CFirstChargeOpenPanel:Ctor(client)
  CFirstChargeOpenPanel.super.Ctor(self, client)
end

function CFirstChargeOpenPanel:Marshal(buffer)
  return true
end

function CFirstChargeOpenPanel:Unmarshal(buffer)
  local ret = true
  return ret
end

return CFirstChargeOpenPanel
