local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSpringSpirit = dataclass("CSpringSpirit", require("framework.net.protocol"))
CSpringSpirit.ProtocolType = 2581
CSpringSpirit.MaxSize = 65535

function CSpringSpirit:Ctor(client)
  CSpringSpirit.super.Ctor(self, client)
end

function CSpringSpirit:Marshal(buffer)
  return true
end

function CSpringSpirit:Unmarshal(buffer)
  local ret = true
  return ret
end

return CSpringSpirit
