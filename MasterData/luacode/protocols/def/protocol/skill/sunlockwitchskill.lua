local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUnlockWitchSkill = dataclass("SUnlockWitchSkill", require("framework.net.protocol"))
SUnlockWitchSkill.ProtocolType = 2104
SUnlockWitchSkill.MaxSize = 65535

function SUnlockWitchSkill:Ctor(client)
  SUnlockWitchSkill.super.Ctor(self, client)
  self.skillItem = require("protocols.bean.protocol.skill.beans.skillitem").Create()
end

function SUnlockWitchSkill:Marshal(buffer)
  if not self.skillItem:Marshal(buffer) then
    return false
  end
  return true
end

function SUnlockWitchSkill:Unmarshal(buffer)
  local ret = true
  if not self.skillItem:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SUnlockWitchSkill
