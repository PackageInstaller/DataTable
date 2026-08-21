-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sspecialweaponskillswitch.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSpecialWeaponSkillSwitch = dataclass("SSpecialWeaponSkillSwitch", require("framework.net.protocol"))
SSpecialWeaponSkillSwitch.ProtocolType = 1259
SSpecialWeaponSkillSwitch.MaxSize = 65535
SSpecialWeaponSkillSwitch.roleId = 0
SSpecialWeaponSkillSwitch.skillOpen = 0
SSpecialWeaponSkillSwitch.OPEN = 0
SSpecialWeaponSkillSwitch.CLOSE = 1
SSpecialWeaponSkillSwitch.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSpecialWeaponSkillSwitch
  ((SSpecialWeaponSkillSwitch.super).Ctor)(self, client)
end

SSpecialWeaponSkillSwitch.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.skillOpen) then
    return false
  end
  return true
end

SSpecialWeaponSkillSwitch.Unmarshal = function(self, buffer)
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
  return ret
end

return SSpecialWeaponSkillSwitch

