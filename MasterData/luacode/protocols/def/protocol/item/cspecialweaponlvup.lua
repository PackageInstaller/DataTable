local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSpecialWeaponlvUp = dataclass("CSpecialWeaponlvUp", require("framework.net.protocol"))
CSpecialWeaponlvUp.ProtocolType = 1256
CSpecialWeaponlvUp.MaxSize = 65535
CSpecialWeaponlvUp.roleId = 0

function CSpecialWeaponlvUp:Ctor(client)
  CSpecialWeaponlvUp.super.Ctor(self, client)
end

function CSpecialWeaponlvUp:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CSpecialWeaponlvUp:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CSpecialWeaponlvUp
