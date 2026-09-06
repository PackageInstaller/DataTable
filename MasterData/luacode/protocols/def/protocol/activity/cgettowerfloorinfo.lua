local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetTowerFloorInfo = dataclass("CGetTowerFloorInfo", require("framework.net.protocol"))
CGetTowerFloorInfo.ProtocolType = 2414
CGetTowerFloorInfo.MaxSize = 65535

function CGetTowerFloorInfo:Ctor(client)
  CGetTowerFloorInfo.super.Ctor(self, client)
end

function CGetTowerFloorInfo:Marshal(buffer)
  return true
end

function CGetTowerFloorInfo:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetTowerFloorInfo
