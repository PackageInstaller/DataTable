local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdatePassiveSkill = dataclass("SUpdatePassiveSkill", require("framework.net.protocol"))
SUpdatePassiveSkill.ProtocolType = 1078
SUpdatePassiveSkill.MaxSize = 65535
SUpdatePassiveSkill.roleId = 0
SUpdatePassiveSkill.oldSkillId = 0
SUpdatePassiveSkill.newSKillId = 0

function SUpdatePassiveSkill:Ctor(client)
  SUpdatePassiveSkill.super.Ctor(self, client)
end

function SUpdatePassiveSkill:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.oldSkillId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.newSKillId) then
    return false
  end
  return true
end

function SUpdatePassiveSkill:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.oldSkillId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.newSKillId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUpdatePassiveSkill
