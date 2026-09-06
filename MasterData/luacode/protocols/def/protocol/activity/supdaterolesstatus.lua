local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUpdateRolesStatus = dataclass("SUpdateRolesStatus", require("framework.net.protocol"))
SUpdateRolesStatus.ProtocolType = 2539
SUpdateRolesStatus.MaxSize = 65535

function SUpdateRolesStatus:Ctor(client)
  SUpdateRolesStatus.super.Ctor(self, client)
  self.roleStatus = {}
end

function SUpdateRolesStatus:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.roleStatus)) then
    return false
  end
  for key, value in pairs(self.roleStatus) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SUpdateRolesStatus:Unmarshal(buffer)
  local ret = true
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
    self.roleStatus[key] = value
  end
  return ret
end

return SUpdateRolesStatus
