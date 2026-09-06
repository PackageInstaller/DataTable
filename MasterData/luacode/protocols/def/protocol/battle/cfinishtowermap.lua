local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFinishTowerMap = dataclass("CFinishTowerMap", require("framework.net.protocol"))
CFinishTowerMap.ProtocolType = 1988
CFinishTowerMap.MaxSize = 65535

function CFinishTowerMap:Ctor(client)
  CFinishTowerMap.super.Ctor(self, client)
end

function CFinishTowerMap:Marshal(buffer)
  return true
end

function CFinishTowerMap:Unmarshal(buffer)
  local ret = true
  return ret
end

return CFinishTowerMap
