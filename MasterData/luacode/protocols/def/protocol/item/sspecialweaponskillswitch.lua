local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSpecialWeaponSkillSwitch = dataclass("SSpecialWeaponSkillSwitch", require("framework.net.protocol"))
SSpecialWeaponSkillSwitch.ProtocolType = 1259
SSpecialWeaponSkillSwitch.MaxSize = 65535
SSpecialWeaponSkillSwitch.roleId = 0
SSpecialWeaponSkillSwitch.skillOpen = 0
SSpecialWeaponSkillSwitch.OPEN = 0
SSpecialWeaponSkillSwitch.CLOSE = 1

function SSpecialWeaponSkillSwitch:Ctor(client)
  SSpecialWeaponSkillSwitch.super.Ctor(self, client)
end

function SSpecialWeaponSkillSwitch:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skillOpen) then
    return false
  end
  return true
end

function SSpecialWeaponSkillSwitch:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.skillOpen = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSpecialWeaponSkillSwitch
