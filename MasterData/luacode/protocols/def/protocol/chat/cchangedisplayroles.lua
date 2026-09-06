local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeDisplayRoles = dataclass("CChangeDisplayRoles", require("framework.net.protocol"))
CChangeDisplayRoles.ProtocolType = 1141
CChangeDisplayRoles.MaxSize = 65535

function CChangeDisplayRoles:Ctor(client)
  CChangeDisplayRoles.super.Ctor(self, client)
  self.roleIds = {}
end

function CChangeDisplayRoles:Marshal(buffer)
  local length = table.slen(self.roleIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleIds[i]) then
      return false
    end
  end
  return true
end

function CChangeDisplayRoles:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.roleIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CChangeDisplayRoles
