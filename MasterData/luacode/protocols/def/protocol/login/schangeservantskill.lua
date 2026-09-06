local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeServantSkill = dataclass("SChangeServantSkill", require("framework.net.protocol"))
SChangeServantSkill.ProtocolType = 1048
SChangeServantSkill.MaxSize = 65535
SChangeServantSkill.lineupId = 0
SChangeServantSkill.result = 0

function SChangeServantSkill:Ctor(client)
  SChangeServantSkill.super.Ctor(self, client)
end

function SChangeServantSkill:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.result) then
    return false
  end
  return true
end

function SChangeServantSkill:Unmarshal(buffer)
  local ret = true
  ret, self.lineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeServantSkill
