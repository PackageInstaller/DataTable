local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CQueryAnniversaryShareInfo = dataclass("CQueryAnniversaryShareInfo", require("framework.net.protocol"))
CQueryAnniversaryShareInfo.ProtocolType = 2692
CQueryAnniversaryShareInfo.MaxSize = 65535

function CQueryAnniversaryShareInfo:Ctor(client)
  CQueryAnniversaryShareInfo.super.Ctor(self, client)
end

function CQueryAnniversaryShareInfo:Marshal(buffer)
  return true
end

function CQueryAnniversaryShareInfo:Unmarshal(buffer)
  local ret = true
  return ret
end

return CQueryAnniversaryShareInfo
