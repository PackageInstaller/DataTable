local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFantasyConflictOpenPanel = dataclass("CFantasyConflictOpenPanel", require("framework.net.protocol"))
CFantasyConflictOpenPanel.ProtocolType = 4149
CFantasyConflictOpenPanel.MaxSize = 65535

function CFantasyConflictOpenPanel:Ctor(client)
  CFantasyConflictOpenPanel.super.Ctor(self, client)
end

function CFantasyConflictOpenPanel:Marshal(buffer)
  return true
end

function CFantasyConflictOpenPanel:Unmarshal(buffer)
  local ret = true
  return ret
end

return CFantasyConflictOpenPanel
