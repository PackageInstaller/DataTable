local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateTowerLineupStatue = dataclass("SUpdateTowerLineupStatue", require("framework.net.protocol"))
SUpdateTowerLineupStatue.ProtocolType = 2430
SUpdateTowerLineupStatue.MaxSize = 65535
SUpdateTowerLineupStatue.lineupID = 0

function SUpdateTowerLineupStatue:Ctor(client)
  SUpdateTowerLineupStatue.super.Ctor(self, client)
  self.rolesState = {}
end

function SUpdateTowerLineupStatue:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.rolesState)) then
    return false
  end
  for key, value in pairs(self.rolesState) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SUpdateTowerLineupStatue:Unmarshal(buffer)
  local ret = true
  ret, self.lineupID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
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
    self.rolesState[key] = value
  end
  return ret
end

return SUpdateTowerLineupStatue
