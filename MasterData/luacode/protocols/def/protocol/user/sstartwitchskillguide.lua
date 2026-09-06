local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SStartWitchSkillGuide = dataclass("SStartWitchSkillGuide", require("framework.net.protocol"))
SStartWitchSkillGuide.ProtocolType = 2217
SStartWitchSkillGuide.MaxSize = 65535
SStartWitchSkillGuide.guide = 0

function SStartWitchSkillGuide:Ctor(client)
  SStartWitchSkillGuide.super.Ctor(self, client)
  self.skillItemIds = {}
end

function SStartWitchSkillGuide:Marshal(buffer)
  local length = table.slen(self.skillItemIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skillItemIds[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.guide) then
    return false
  end
  return true
end

function SStartWitchSkillGuide:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.skillItemIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.guide = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SStartWitchSkillGuide
