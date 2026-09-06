local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRoleLock = dataclass("SRoleLock", require("framework.net.protocol"))
SRoleLock.ProtocolType = 1015
SRoleLock.MaxSize = 65535
SRoleLock.roleId = 0
SRoleLock.lock = 0

function SRoleLock:Ctor(client)
  SRoleLock.super.Ctor(self, client)
end

function SRoleLock:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.lock) then
    return false
  end
  return true
end

function SRoleLock:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lock = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRoleLock
