local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRuneLevelUp = dataclass("CRuneLevelUp", require("framework.net.protocol"))
CRuneLevelUp.ProtocolType = 1097
CRuneLevelUp.MaxSize = 65535
CRuneLevelUp.roleId = 0
CRuneLevelUp.runeId = 0
CRuneLevelUp.MAX_HP = 1
CRuneLevelUp.ATTACK = 2
CRuneLevelUp.DEFEND = 3
CRuneLevelUp.MAGIC_DEFEND = 4

function CRuneLevelUp:Ctor(client)
  CRuneLevelUp.super.Ctor(self, client)
end

function CRuneLevelUp:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.runeId) then
    return false
  end
  return true
end

function CRuneLevelUp:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.runeId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRuneLevelUp
