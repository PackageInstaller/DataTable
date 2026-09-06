local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRoleUpdateProperties = dataclass("SRoleUpdateProperties", require("framework.net.protocol"))
SRoleUpdateProperties.ProtocolType = 1020
SRoleUpdateProperties.MaxSize = 65535
SRoleUpdateProperties.roleId = 0

function SRoleUpdateProperties:Ctor(client)
  SRoleUpdateProperties.super.Ctor(self, client)
  self.properties = {}
end

function SRoleUpdateProperties:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.properties)) then
    return false
  end
  for key, value in pairs(self.properties) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SRoleUpdateProperties:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.properties[key] = value
  end
  return ret
end

return SRoleUpdateProperties
