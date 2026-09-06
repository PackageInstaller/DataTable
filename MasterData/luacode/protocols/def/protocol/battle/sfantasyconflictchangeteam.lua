local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFantasyConflictChangeTeam = dataclass("SFantasyConflictChangeTeam", require("framework.net.protocol"))
SFantasyConflictChangeTeam.ProtocolType = 4158
SFantasyConflictChangeTeam.MaxSize = 65535
SFantasyConflictChangeTeam.teamType = 0

function SFantasyConflictChangeTeam:Ctor(client)
  SFantasyConflictChangeTeam.super.Ctor(self, client)
  self.team = {}
end

function SFantasyConflictChangeTeam:Marshal(buffer)
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

function SFantasyConflictChangeTeam:Unmarshal(buffer)
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

return SFantasyConflictChangeTeam
