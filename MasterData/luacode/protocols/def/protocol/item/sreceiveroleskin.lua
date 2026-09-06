local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveRoleSkin = dataclass("SReceiveRoleSkin", require("framework.net.protocol"))
SReceiveRoleSkin.ProtocolType = 1251
SReceiveRoleSkin.MaxSize = 65535
SReceiveRoleSkin.roleId = 0

function SReceiveRoleSkin:Ctor(client)
  SReceiveRoleSkin.super.Ctor(self, client)
  self.skins = require("protocols.bean.protocol.item.beans.skininfo").Create()
end

function SReceiveRoleSkin:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not self.skins:Marshal(buffer) then
    return false
  end
  return true
end

function SReceiveRoleSkin:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.skins:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SReceiveRoleSkin
