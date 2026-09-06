local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetLoverActivityInfo = dataclass("CGetLoverActivityInfo", require("framework.net.protocol"))
CGetLoverActivityInfo.ProtocolType = 2588
CGetLoverActivityInfo.MaxSize = 65535

function CGetLoverActivityInfo:Ctor(client)
  CGetLoverActivityInfo.super.Ctor(self, client)
end

function CGetLoverActivityInfo:Marshal(buffer)
  return true
end

function CGetLoverActivityInfo:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetLoverActivityInfo
