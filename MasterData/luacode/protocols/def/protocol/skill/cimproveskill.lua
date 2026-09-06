local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CImproveSkill = dataclass("CImproveSkill", require("framework.net.protocol"))
CImproveSkill.ProtocolType = 2101
CImproveSkill.MaxSize = 65535
CImproveSkill.roleId = 0
CImproveSkill.unlockNode = 0

function CImproveSkill:Ctor(client)
  CImproveSkill.super.Ctor(self, client)
end

function CImproveSkill:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.unlockNode) then
    return false
  end
  return true
end

function CImproveSkill:Unmarshal(buffer)
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

return CImproveSkill
