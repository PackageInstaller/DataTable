local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSpringBossState = dataclass("CSpringBossState", require("framework.net.protocol"))
CSpringBossState.ProtocolType = 2578
CSpringBossState.MaxSize = 65535

function CSpringBossState:Ctor(client)
  CSpringBossState.super.Ctor(self, client)
end

function CSpringBossState:Marshal(buffer)
  return true
end

function CSpringBossState:Unmarshal(buffer)
  local ret = true
  return ret
end

return CSpringBossState
