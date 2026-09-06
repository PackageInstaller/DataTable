local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLightTowerPanelRedpoint = dataclass("SLightTowerPanelRedpoint", require("framework.net.protocol"))
SLightTowerPanelRedpoint.ProtocolType = 2000
SLightTowerPanelRedpoint.MaxSize = 65535
SLightTowerPanelRedpoint.light = 0

function SLightTowerPanelRedpoint:Ctor(client)
  SLightTowerPanelRedpoint.super.Ctor(self, client)
end

function SLightTowerPanelRedpoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.light) then
    return false
  end
  return true
end

function SLightTowerPanelRedpoint:Unmarshal(buffer)
  local ret = true
  ret, self.light = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLightTowerPanelRedpoint
