local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAddRolesInRoom = dataclass("CAddRolesInRoom", require("framework.net.protocol"))
CAddRolesInRoom.ProtocolType = 2367
CAddRolesInRoom.MaxSize = 65535
CAddRolesInRoom.floorId = 0

function CAddRolesInRoom:Ctor(client)
  CAddRolesInRoom.super.Ctor(self, client)
  self.roles = {}
end

function CAddRolesInRoom:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.floorId) then
    return false
  end
  local length = table.slen(self.roles)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roles[i]) then
      return false
    end
  end
  return true
end

function CAddRolesInRoom:Unmarshal(buffer)
  local ret = true
  ret, self.floorId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.roles[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CAddRolesInRoom
