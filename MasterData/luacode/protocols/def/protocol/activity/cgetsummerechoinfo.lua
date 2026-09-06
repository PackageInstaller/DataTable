local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetSummerEchoInfo = dataclass("CGetSummerEchoInfo", require("framework.net.protocol"))
CGetSummerEchoInfo.ProtocolType = 2703
CGetSummerEchoInfo.MaxSize = 65535

function CGetSummerEchoInfo:Ctor(client)
  CGetSummerEchoInfo.super.Ctor(self, client)
end

function CGetSummerEchoInfo:Marshal(buffer)
  return true
end

function CGetSummerEchoInfo:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetSummerEchoInfo
