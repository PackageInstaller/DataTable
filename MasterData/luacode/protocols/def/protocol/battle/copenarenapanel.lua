local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenArenaPanel = dataclass("COpenArenaPanel", require("framework.net.protocol"))
COpenArenaPanel.ProtocolType = 4107
COpenArenaPanel.MaxSize = 65535

function COpenArenaPanel:Ctor(client)
  COpenArenaPanel.super.Ctor(self, client)
end

function COpenArenaPanel:Marshal(buffer)
  return true
end

function COpenArenaPanel:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenArenaPanel
