local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeServantSkill = dataclass("CChangeServantSkill", require("framework.net.protocol"))
CChangeServantSkill.ProtocolType = 1047
CChangeServantSkill.MaxSize = 65535
CChangeServantSkill.lineupId = 0
CChangeServantSkill.skillId = 0

function CChangeServantSkill:Ctor(client)
  CChangeServantSkill.super.Ctor(self, client)
end

function CChangeServantSkill:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skillId) then
    return false
  end
  return true
end

function CChangeServantSkill:Unmarshal(buffer)
  local ret = true
  ret, self.lineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.skillId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeServantSkill
