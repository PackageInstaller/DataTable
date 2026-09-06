local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetRoleSkin = dataclass("CGetRoleSkin", require("framework.net.protocol"))
CGetRoleSkin.ProtocolType = 1249
CGetRoleSkin.MaxSize = 65535
CGetRoleSkin.roleId = 0

function CGetRoleSkin:Ctor(client)
  CGetRoleSkin.super.Ctor(self, client)
end

function CGetRoleSkin:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  return true
end

function CGetRoleSkin:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetRoleSkin
