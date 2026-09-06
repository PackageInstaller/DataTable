local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SImproveTalent = dataclass("SImproveTalent", require("framework.net.protocol"))
SImproveTalent.ProtocolType = 4146
SImproveTalent.MaxSize = 65535
SImproveTalent.unlockNode = 0

function SImproveTalent:Ctor(client)
  SImproveTalent.super.Ctor(self, client)
end

function SImproveTalent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.unlockNode) then
    return false
  end
  return true
end

function SImproveTalent:Unmarshal(buffer)
  local ret = true
  ret, self.unlockNode = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SImproveTalent
