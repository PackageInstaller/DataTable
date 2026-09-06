local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SWeekBossTalent = dataclass("SWeekBossTalent", require("framework.net.protocol"))
SWeekBossTalent.ProtocolType = 4144
SWeekBossTalent.MaxSize = 65535
SWeekBossTalent.leftNum = 0

function SWeekBossTalent:Ctor(client)
  SWeekBossTalent.super.Ctor(self, client)
  self.unlockedTalentNode = {}
end

function SWeekBossTalent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftNum) then
    return false
  end
  local length = table.slen(self.unlockedTalentNode)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.unlockedTalentNode[i]) then
      return false
    end
  end
  return true
end

function SWeekBossTalent:Unmarshal(buffer)
  local ret = true
  ret, self.leftNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.unlockedTalentNode[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SWeekBossTalent
