-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sgetspecialweaponinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetSpecialWeaponInfo = dataclass("SGetSpecialWeaponInfo", require("framework.net.protocol"))
SGetSpecialWeaponInfo.ProtocolType = 1255
SGetSpecialWeaponInfo.MaxSize = 65535
SGetSpecialWeaponInfo.roleId = 0
SGetSpecialWeaponInfo.specialWeaponLevel = 0
SGetSpecialWeaponInfo.skillOpen = 0
SGetSpecialWeaponInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetSpecialWeaponInfo
  ((SGetSpecialWeaponInfo.super).Ctor)(self, client)
  self.specialWeaponProperties = {}
  self.specialWeaponPropertiesForNextLevel = {}
end

SGetSpecialWeaponInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.specialWeaponLevel) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.specialWeaponProperties)) then
    return false
  end
  for key,value in pairs(self.specialWeaponProperties) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.specialWeaponPropertiesForNextLevel)) then
    return false
  end
  for key,value in pairs(self.specialWeaponPropertiesForNextLevel) do
    -- DECOMPILER ERROR at PC66: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
    -- DECOMPILER ERROR at PC74: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.skillOpen) then
    return false
  end
  return true
end

SGetSpecialWeaponInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC45: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.specialWeaponProperties)[key] = value
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC81: Overwrote pending register: R8 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC87: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.specialWeaponPropertiesForNextLevel)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetSpecialWeaponInfo

