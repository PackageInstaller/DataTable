local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CPreviewTowerFloorStatue = dataclass("CPreviewTowerFloorStatue", require("framework.net.protocol"))
CPreviewTowerFloorStatue.ProtocolType = 2434
CPreviewTowerFloorStatue.MaxSize = 65535

function CPreviewTowerFloorStatue:Ctor(client)
  CPreviewTowerFloorStatue.super.Ctor(self, client)
end

function CPreviewTowerFloorStatue:Marshal(buffer)
  return true
end

function CPreviewTowerFloorStatue:Unmarshal(buffer)
  local ret = true
  return ret
end

return CPreviewTowerFloorStatue
