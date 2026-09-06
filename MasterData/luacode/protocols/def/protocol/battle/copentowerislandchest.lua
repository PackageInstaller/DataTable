local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenTowerIslandChest = dataclass("COpenTowerIslandChest", require("framework.net.protocol"))
COpenTowerIslandChest.ProtocolType = 1985
COpenTowerIslandChest.MaxSize = 65535
COpenTowerIslandChest.islandID = 0
COpenTowerIslandChest.choice = 0

function COpenTowerIslandChest:Ctor(client)
  COpenTowerIslandChest.super.Ctor(self, client)
end

function COpenTowerIslandChest:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.islandID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.choice) then
    return false
  end
  return true
end

function COpenTowerIslandChest:Unmarshal(buffer)
  local ret = true
  ret, self.islandID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.choice = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return COpenTowerIslandChest
