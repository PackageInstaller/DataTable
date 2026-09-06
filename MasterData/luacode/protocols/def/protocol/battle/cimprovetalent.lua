local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CImproveTalent = dataclass("CImproveTalent", require("framework.net.protocol"))
CImproveTalent.ProtocolType = 4145
CImproveTalent.MaxSize = 65535
CImproveTalent.unlockNode = 0

function CImproveTalent:Ctor(client)
  CImproveTalent.super.Ctor(self, client)
end

function CImproveTalent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.unlockNode) then
    return false
  end
  return true
end

function CImproveTalent:Unmarshal(buffer)
  local ret = true
  ret, self.unlockNode = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CImproveTalent
