local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeRoles = dataclass("CChangeRoles", require("framework.net.protocol"))
CChangeRoles.ProtocolType = 1041
CChangeRoles.MaxSize = 65535
CChangeRoles.lineupId = 0
CChangeRoles.station = 0
CChangeRoles.roleId = 0

function CChangeRoles:Ctor(client)
  CChangeRoles.super.Ctor(self, client)
end

function CChangeRoles:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.station) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CChangeRoles:Unmarshal(buffer)
  local ret = true
  ret, self.lineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.station = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeRoles
