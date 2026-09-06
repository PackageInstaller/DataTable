local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUnlockTalent = dataclass("SUnlockTalent", require("framework.net.protocol"))
SUnlockTalent.ProtocolType = 1077
SUnlockTalent.MaxSize = 65535
SUnlockTalent.roleId = 0
SUnlockTalent.talentPage = 0
SUnlockTalent.talentRow = 0

function SUnlockTalent:Ctor(client)
  SUnlockTalent.super.Ctor(self, client)
  self.talentInRow = {}
end

function SUnlockTalent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.talentPage) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.talentRow) then
    return false
  end
  local length = table.slen(self.talentInRow)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.talentInRow[i]) then
      return false
    end
  end
  return true
end

function SUnlockTalent:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.talentPage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.talentRow = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.talentInRow[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SUnlockTalent
