local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CStartTowerExplore = dataclass("CStartTowerExplore", require("framework.net.protocol"))
CStartTowerExplore.ProtocolType = 1981
CStartTowerExplore.MaxSize = 65535
CStartTowerExplore.tower = 0

function CStartTowerExplore:Ctor(client)
  CStartTowerExplore.super.Ctor(self, client)
end

function CStartTowerExplore:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.tower) then
    return false
  end
  return true
end

function CStartTowerExplore:Unmarshal(buffer)
  local ret = true
  ret, self.tower = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CStartTowerExplore
