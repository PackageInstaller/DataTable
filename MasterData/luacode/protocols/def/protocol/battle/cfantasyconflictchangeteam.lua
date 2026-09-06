local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFantasyConflictChangeTeam = dataclass("CFantasyConflictChangeTeam", require("framework.net.protocol"))
CFantasyConflictChangeTeam.ProtocolType = 4157
CFantasyConflictChangeTeam.MaxSize = 65535
CFantasyConflictChangeTeam.teamType = 0

function CFantasyConflictChangeTeam:Ctor(client)
  CFantasyConflictChangeTeam.super.Ctor(self, client)
  self.team = {}
end

function CFantasyConflictChangeTeam:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.teamType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.team)) then
    return false
  end
  for key, value in pairs(self.team) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function CFantasyConflictChangeTeam:Unmarshal(buffer)
  local ret = true
  ret, self.teamType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.team[key] = value
  end
  return ret
end

return CFantasyConflictChangeTeam
