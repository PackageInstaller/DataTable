local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFinishWitchSkillGuide = dataclass("CFinishWitchSkillGuide", require("framework.net.protocol"))
CFinishWitchSkillGuide.ProtocolType = 2218
CFinishWitchSkillGuide.MaxSize = 65535
CFinishWitchSkillGuide.skillItemId = 0

function CFinishWitchSkillGuide:Ctor(client)
  CFinishWitchSkillGuide.super.Ctor(self, client)
end

function CFinishWitchSkillGuide:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skillItemId) then
    return false
  end
  return true
end

function CFinishWitchSkillGuide:Unmarshal(buffer)
  local ret = true
  ret, self.skillItemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFinishWitchSkillGuide
