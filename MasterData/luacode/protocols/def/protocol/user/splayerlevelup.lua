local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPlayerLevelUp = dataclass("SPlayerLevelUp", require("framework.net.protocol"))
SPlayerLevelUp.ProtocolType = 2266
SPlayerLevelUp.MaxSize = 65535
SPlayerLevelUp.level = 0
SPlayerLevelUp.strengthLimit = 0
SPlayerLevelUp.roleMaxLv = 0
SPlayerLevelUp.strengthGet = 0

function SPlayerLevelUp:Ctor(client)
  SPlayerLevelUp.super.Ctor(self, client)
end

function SPlayerLevelUp:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.strengthLimit) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleMaxLv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.strengthGet) then
    return false
  end
  return true
end

function SPlayerLevelUp:Unmarshal(buffer)
  local ret = true
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.strengthLimit = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleMaxLv = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.strengthGet = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SPlayerLevelUp
