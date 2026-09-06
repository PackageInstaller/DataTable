local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetSpecialWeaponInfo = dataclass("SGetSpecialWeaponInfo", require("framework.net.protocol"))
SGetSpecialWeaponInfo.ProtocolType = 1255
SGetSpecialWeaponInfo.MaxSize = 65535
SGetSpecialWeaponInfo.roleId = 0
SGetSpecialWeaponInfo.specialWeaponLevel = 0
SGetSpecialWeaponInfo.skillOpen = 0

function SGetSpecialWeaponInfo:Ctor(client)
  SGetSpecialWeaponInfo.super.Ctor(self, client)
  self.specialWeaponProperties = {}
  self.specialWeaponPropertiesForNextLevel = {}
end

function SGetSpecialWeaponInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.specialWeaponLevel) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.specialWeaponProperties)) then
    return false
  end
  for key, value in pairs(self.specialWeaponProperties) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.specialWeaponPropertiesForNextLevel)) then
    return false
  end
  for key, value in pairs(self.specialWeaponPropertiesForNextLevel) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skillOpen) then
    return false
  end
  return true
end

function SGetSpecialWeaponInfo:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.specialWeaponLevel = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.specialWeaponProperties[key] = value
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
    self.specialWeaponPropertiesForNextLevel[key] = value
  end
  ret, self.skillOpen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetSpecialWeaponInfo
