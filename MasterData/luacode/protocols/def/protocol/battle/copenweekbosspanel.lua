local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenWeekBossPanel = dataclass("COpenWeekBossPanel", require("framework.net.protocol"))
COpenWeekBossPanel.ProtocolType = 4140
COpenWeekBossPanel.MaxSize = 65535

function COpenWeekBossPanel:Ctor(client)
  COpenWeekBossPanel.super.Ctor(self, client)
end

function COpenWeekBossPanel:Marshal(buffer)
  return true
end

function COpenWeekBossPanel:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenWeekBossPanel
