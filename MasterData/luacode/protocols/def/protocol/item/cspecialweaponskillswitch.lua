local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSpecialWeaponSkillSwitch = dataclass("CSpecialWeaponSkillSwitch", require("framework.net.protocol"))
CSpecialWeaponSkillSwitch.ProtocolType = 1258
CSpecialWeaponSkillSwitch.MaxSize = 65535
CSpecialWeaponSkillSwitch.roleId = 0

function CSpecialWeaponSkillSwitch:Ctor(client)
  CSpecialWeaponSkillSwitch.super.Ctor(self, client)
end

function CSpecialWeaponSkillSwitch:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CSpecialWeaponSkillSwitch:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSpecialWeaponSkillSwitch
