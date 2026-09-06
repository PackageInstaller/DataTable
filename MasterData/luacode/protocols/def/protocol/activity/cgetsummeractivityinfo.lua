local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetSummerActivityInfo = dataclass("CGetSummerActivityInfo", require("framework.net.protocol"))
CGetSummerActivityInfo.ProtocolType = 2469
CGetSummerActivityInfo.MaxSize = 65535

function CGetSummerActivityInfo:Ctor(client)
  CGetSummerActivityInfo.super.Ctor(self, client)
end

function CGetSummerActivityInfo:Marshal(buffer)
  return true
end

function CGetSummerActivityInfo:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetSummerActivityInfo
