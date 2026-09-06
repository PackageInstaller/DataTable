local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRequestFantasyConflictTeam = dataclass("CRequestFantasyConflictTeam", require("framework.net.protocol"))
CRequestFantasyConflictTeam.ProtocolType = 4163
CRequestFantasyConflictTeam.MaxSize = 8

function CRequestFantasyConflictTeam:Ctor(client)
  CRequestFantasyConflictTeam.super.Ctor(self, client)
end

function CRequestFantasyConflictTeam:Marshal(buffer)
  return true
end

function CRequestFantasyConflictTeam:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRequestFantasyConflictTeam
