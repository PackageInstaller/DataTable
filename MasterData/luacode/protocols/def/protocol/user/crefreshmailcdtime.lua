local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReFreshMailCDTime = dataclass("CReFreshMailCDTime", require("framework.net.protocol"))
CReFreshMailCDTime.ProtocolType = 2275
CReFreshMailCDTime.MaxSize = 65535

function CReFreshMailCDTime:Ctor(client)
  CReFreshMailCDTime.super.Ctor(self, client)
end

function CReFreshMailCDTime:Marshal(buffer)
  return true
end

function CReFreshMailCDTime:Unmarshal(buffer)
  local ret = true
  return ret
end

return CReFreshMailCDTime
