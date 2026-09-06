local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenTowerList = dataclass("SOpenTowerList", require("framework.net.protocol"))
SOpenTowerList.ProtocolType = 1978
SOpenTowerList.MaxSize = 65535
SOpenTowerList.chanceLeft = 0
SOpenTowerList.totalChance = 0
SOpenTowerList.challenging = 0
SOpenTowerList.challengingFloor = 0
SOpenTowerList.resetTimeLeft = 0

function SOpenTowerList:Ctor(client)
  SOpenTowerList.super.Ctor(self, client)
  self.towerUnlock = {}
end

function SOpenTowerList:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.towerUnlock)) then
    return false
  end
  for key, value in pairs(self.towerUnlock) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chanceLeft) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalChance) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.challenging) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.challengingFloor) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.resetTimeLeft) then
    return false
  end
  return true
end

function SOpenTowerList:Unmarshal(buffer)
  local ret = true
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.towerUnlock[key] = value
  end
  ret, self.chanceLeft = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalChance = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.challenging = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.challengingFloor = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.resetTimeLeft = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenTowerList
