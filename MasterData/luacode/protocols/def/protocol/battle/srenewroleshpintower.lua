local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRenewRolesHPinTower = dataclass("SRenewRolesHPinTower", require("framework.net.protocol"))
SRenewRolesHPinTower.ProtocolType = 1999
SRenewRolesHPinTower.MaxSize = 65535

function SRenewRolesHPinTower:Ctor(client)
  SRenewRolesHPinTower.super.Ctor(self, client)
  self.status = {}
end

function SRenewRolesHPinTower:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.status)) then
    return false
  end
  for key, value in pairs(self.status) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SRenewRolesHPinTower:Unmarshal(buffer)
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
    self.status[key] = value
  end
  return ret
end

return SRenewRolesHPinTower
