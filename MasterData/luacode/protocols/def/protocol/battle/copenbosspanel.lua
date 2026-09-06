local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenBossPanel = dataclass("COpenBossPanel", require("framework.net.protocol"))
COpenBossPanel.ProtocolType = 1950
COpenBossPanel.MaxSize = 65535

function COpenBossPanel:Ctor(client)
  COpenBossPanel.super.Ctor(self, client)
end

function COpenBossPanel:Marshal(buffer)
  return true
end

function COpenBossPanel:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenBossPanel
