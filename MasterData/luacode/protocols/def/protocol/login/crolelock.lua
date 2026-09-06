local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRoleLock = dataclass("CRoleLock", require("framework.net.protocol"))
CRoleLock.ProtocolType = 1014
CRoleLock.MaxSize = 65535
CRoleLock.roleId = 0

function CRoleLock:Ctor(client)
  CRoleLock.super.Ctor(self, client)
end

function CRoleLock:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CRoleLock:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRoleLock
