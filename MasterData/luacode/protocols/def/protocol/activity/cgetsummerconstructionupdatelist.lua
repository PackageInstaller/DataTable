local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetSummerConstructionUpdateList = dataclass("CGetSummerConstructionUpdateList", require("framework.net.protocol"))
CGetSummerConstructionUpdateList.ProtocolType = 2473
CGetSummerConstructionUpdateList.MaxSize = 65535

function CGetSummerConstructionUpdateList:Ctor(client)
  CGetSummerConstructionUpdateList.super.Ctor(self, client)
end

function CGetSummerConstructionUpdateList:Marshal(buffer)
  return true
end

function CGetSummerConstructionUpdateList:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetSummerConstructionUpdateList
