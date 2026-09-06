local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReFreshPhoneCDTime = dataclass("CReFreshPhoneCDTime", require("framework.net.protocol"))
CReFreshPhoneCDTime.ProtocolType = 2276
CReFreshPhoneCDTime.MaxSize = 65535

function CReFreshPhoneCDTime:Ctor(client)
  CReFreshPhoneCDTime.super.Ctor(self, client)
end

function CReFreshPhoneCDTime:Marshal(buffer)
  return true
end

function CReFreshPhoneCDTime:Unmarshal(buffer)
  local ret = true
  return ret
end

return CReFreshPhoneCDTime
