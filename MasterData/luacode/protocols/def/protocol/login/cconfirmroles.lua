local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CConfirmRoles = dataclass("CConfirmRoles", require("framework.net.protocol"))
CConfirmRoles.ProtocolType = 1084
CConfirmRoles.MaxSize = 65535
CConfirmRoles.lineupId = 0

function CConfirmRoles:Ctor(client)
  CConfirmRoles.super.Ctor(self, client)
  self.roles = {}
end

function CConfirmRoles:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lineupId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.roles)) then
    return false
  end
  for key, value in pairs(self.roles) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function CConfirmRoles:Unmarshal(buffer)
  local ret = true
  ret, self.lineupId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.roles[key] = value
  end
  return ret
end

return CConfirmRoles
