local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReqSpirit = dataclass("CReqSpirit", require("framework.net.protocol"))
CReqSpirit.ProtocolType = 1233
CReqSpirit.MaxSize = 65535

function CReqSpirit:Ctor(client)
  CReqSpirit.super.Ctor(self, client)
end

function CReqSpirit:Marshal(buffer)
  return true
end

function CReqSpirit:Unmarshal(buffer)
  local ret = true
  return ret
end

return CReqSpirit
