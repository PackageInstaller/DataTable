local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUnlockTalent = dataclass("CUnlockTalent", require("framework.net.protocol"))
CUnlockTalent.ProtocolType = 1076
CUnlockTalent.MaxSize = 65535
CUnlockTalent.roleId = 0
CUnlockTalent.pos = 0

function CUnlockTalent:Ctor(client)
  CUnlockTalent.super.Ctor(self, client)
end

function CUnlockTalent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pos) then
    return false
  end
  return true
end

function CUnlockTalent:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.pos = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUnlockTalent
