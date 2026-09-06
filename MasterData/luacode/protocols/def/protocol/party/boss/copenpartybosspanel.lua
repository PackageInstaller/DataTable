local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenPartyBossPanel = dataclass("COpenPartyBossPanel", require("framework.net.protocol"))
COpenPartyBossPanel.ProtocolType = 5040
COpenPartyBossPanel.MaxSize = 8

function COpenPartyBossPanel:Ctor(client)
  COpenPartyBossPanel.super.Ctor(self, client)
end

function COpenPartyBossPanel:Marshal(buffer)
  return true
end

function COpenPartyBossPanel:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenPartyBossPanel
