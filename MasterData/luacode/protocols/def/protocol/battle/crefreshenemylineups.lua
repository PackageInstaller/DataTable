local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRefreshEnemyLineups = dataclass("CRefreshEnemyLineups", require("framework.net.protocol"))
CRefreshEnemyLineups.ProtocolType = 4112
CRefreshEnemyLineups.MaxSize = 65535

function CRefreshEnemyLineups:Ctor(client)
  CRefreshEnemyLineups.super.Ctor(self, client)
end

function CRefreshEnemyLineups:Marshal(buffer)
  return true
end

function CRefreshEnemyLineups:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRefreshEnemyLineups
