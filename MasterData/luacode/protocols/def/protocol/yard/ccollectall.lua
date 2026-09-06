local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCollectAll = dataclass("CCollectAll", require("framework.net.protocol"))
CCollectAll.ProtocolType = 2322
CCollectAll.MaxSize = 65535

function CCollectAll:Ctor(client)
  CCollectAll.super.Ctor(self, client)
end

function CCollectAll:Marshal(buffer)
  return true
end

function CCollectAll:Unmarshal(buffer)
  local ret = true
  return ret
end

return CCollectAll
