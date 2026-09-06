local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetChristmasActivityInfo = dataclass("CGetChristmasActivityInfo", require("framework.net.protocol"))
CGetChristmasActivityInfo.ProtocolType = 2525
CGetChristmasActivityInfo.MaxSize = 65535

function CGetChristmasActivityInfo:Ctor(client)
  CGetChristmasActivityInfo.super.Ctor(self, client)
end

function CGetChristmasActivityInfo:Marshal(buffer)
  return true
end

function CGetChristmasActivityInfo:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetChristmasActivityInfo
