local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReplaceRolesInCavern = dataclass("CReplaceRolesInCavern", require("framework.net.protocol"))
CReplaceRolesInCavern.ProtocolType = 2323
CReplaceRolesInCavern.MaxSize = 65535
CReplaceRolesInCavern.id = 0

function CReplaceRolesInCavern:Ctor(client)
  CReplaceRolesInCavern.super.Ctor(self, client)
  self.roleIds = {}
end

function CReplaceRolesInCavern:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
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

function CReplaceRolesInCavern:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
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

return CReplaceRolesInCavern
