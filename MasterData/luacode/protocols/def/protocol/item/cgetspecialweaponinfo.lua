local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetSpecialWeaponInfo = dataclass("CGetSpecialWeaponInfo", require("framework.net.protocol"))
CGetSpecialWeaponInfo.ProtocolType = 1254
CGetSpecialWeaponInfo.MaxSize = 65535
CGetSpecialWeaponInfo.roleId = 0

function CGetSpecialWeaponInfo:Ctor(client)
  CGetSpecialWeaponInfo.super.Ctor(self, client)
end

function CGetSpecialWeaponInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CGetSpecialWeaponInfo:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetSpecialWeaponInfo
