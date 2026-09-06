local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenSideQuestPanel = dataclass("COpenSideQuestPanel", require("framework.net.protocol"))
COpenSideQuestPanel.ProtocolType = 2421
COpenSideQuestPanel.MaxSize = 65536

function COpenSideQuestPanel:Ctor(client)
  COpenSideQuestPanel.super.Ctor(self, client)
end

function COpenSideQuestPanel:Marshal(buffer)
  return true
end

function COpenSideQuestPanel:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenSideQuestPanel
