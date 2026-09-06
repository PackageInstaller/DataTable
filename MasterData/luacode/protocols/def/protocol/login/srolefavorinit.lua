local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRoleFavorInit = dataclass("SRoleFavorInit", require("framework.net.protocol"))
SRoleFavorInit.ProtocolType = 1018
SRoleFavorInit.MaxSize = 65535
SRoleFavorInit.id = 0

function SRoleFavorInit:Ctor(client)
  SRoleFavorInit.super.Ctor(self, client)
  self.favor = require("protocols.bean.protocol.login.favor").Create()
end

function SRoleFavorInit:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not self.favor:Marshal(buffer) then
    return false
  end
  return true
end

function SRoleFavorInit:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.favor:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRoleFavorInit
