local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendAssistRoles = dataclass("SSendAssistRoles", require("framework.net.protocol"))
SSendAssistRoles.ProtocolType = 1144
SSendAssistRoles.MaxSize = 65535
SSendAssistRoles.supportRole = 0

function SSendAssistRoles:Ctor(client)
  SSendAssistRoles.super.Ctor(self, client)
  self.displayRole = {}
end

function SSendAssistRoles:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.supportRole) then
    return false
  end
  local length = table.slen(self.displayRole)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.displayRole[i]) then
      return false
    end
  end
  return true
end

function SSendAssistRoles:Unmarshal(buffer)
  local ret = true
  ret, self.supportRole = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.displayRole[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SSendAssistRoles
