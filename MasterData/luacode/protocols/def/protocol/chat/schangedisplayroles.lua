local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeDisplayRoles = dataclass("SChangeDisplayRoles", require("framework.net.protocol"))
SChangeDisplayRoles.ProtocolType = 1143
SChangeDisplayRoles.MaxSize = 65535

function SChangeDisplayRoles:Ctor(client)
  SChangeDisplayRoles.super.Ctor(self, client)
  self.roleIds = {}
end

function SChangeDisplayRoles:Marshal(buffer)
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

function SChangeDisplayRoles:Unmarshal(buffer)
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

return SChangeDisplayRoles
