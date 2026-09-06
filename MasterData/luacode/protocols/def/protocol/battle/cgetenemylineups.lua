local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetEnemyLineups = dataclass("CGetEnemyLineups", require("framework.net.protocol"))
CGetEnemyLineups.ProtocolType = 4121
CGetEnemyLineups.MaxSize = 65535

function CGetEnemyLineups:Ctor(client)
  CGetEnemyLineups.super.Ctor(self, client)
end

function CGetEnemyLineups:Marshal(buffer)
  return true
end

function CGetEnemyLineups:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetEnemyLineups
