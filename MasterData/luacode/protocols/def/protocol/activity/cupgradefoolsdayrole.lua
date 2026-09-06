local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUpgradeFoolsDayRole = dataclass("CUpgradeFoolsDayRole", require("framework.net.protocol"))
CUpgradeFoolsDayRole.ProtocolType = 2630
CUpgradeFoolsDayRole.MaxSize = 65535
CUpgradeFoolsDayRole.Id = 0
CUpgradeFoolsDayRole.upgradeType = 0
CUpgradeFoolsDayRole.LEVEL = 1
CUpgradeFoolsDayRole.WEAPON = 2

function CUpgradeFoolsDayRole:Ctor(client)
  CUpgradeFoolsDayRole.super.Ctor(self, client)
end

function CUpgradeFoolsDayRole:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.Id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.upgradeType) then
    return false
  end
  return true
end

function CUpgradeFoolsDayRole:Unmarshal(buffer)
  local ret = true
  ret, self.Id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.upgradeType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUpgradeFoolsDayRole
