local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SImproveSkill = dataclass("SImproveSkill", require("framework.net.protocol"))
SImproveSkill.ProtocolType = 2103
SImproveSkill.MaxSize = 65535
SImproveSkill.roleId = 0
SImproveSkill.unlockNode = 0

function SImproveSkill:Ctor(client)
  SImproveSkill.super.Ctor(self, client)
end

function SImproveSkill:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.unlockNode) then
    return false
  end
  return true
end

function SImproveSkill:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.unlockNode = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SImproveSkill
