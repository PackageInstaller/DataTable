local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenWatermelonBossPanel = dataclass("COpenWatermelonBossPanel", require("framework.net.protocol"))
COpenWatermelonBossPanel.ProtocolType = 4130
COpenWatermelonBossPanel.MaxSize = 65535

function COpenWatermelonBossPanel:Ctor(client)
  COpenWatermelonBossPanel.super.Ctor(self, client)
end

function COpenWatermelonBossPanel:Marshal(buffer)
  return true
end

function COpenWatermelonBossPanel:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenWatermelonBossPanel
