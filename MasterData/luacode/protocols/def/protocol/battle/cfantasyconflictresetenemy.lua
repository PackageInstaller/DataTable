local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFantasyConflictResetEnemy = dataclass("CFantasyConflictResetEnemy", require("framework.net.protocol"))
CFantasyConflictResetEnemy.ProtocolType = 4161
CFantasyConflictResetEnemy.MaxSize = 65535

function CFantasyConflictResetEnemy:Ctor(client)
  CFantasyConflictResetEnemy.super.Ctor(self, client)
end

function CFantasyConflictResetEnemy:Marshal(buffer)
  return true
end

function CFantasyConflictResetEnemy:Unmarshal(buffer)
  local ret = true
  return ret
end

return CFantasyConflictResetEnemy
