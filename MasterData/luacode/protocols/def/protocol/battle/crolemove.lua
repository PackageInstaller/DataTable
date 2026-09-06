local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRoleMove = dataclass("CRoleMove", require("framework.net.protocol"))
CRoleMove.ProtocolType = 1900
CRoleMove.MaxSize = 65535
CRoleMove.sceneid = 0

function CRoleMove:Ctor(client)
  CRoleMove.super.Ctor(self, client)
  self.position = require("protocols.bean.protocol.battle.point").Create()
end

function CRoleMove:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sceneid) then
    return false
  end
  if not self.position:Marshal(buffer) then
    return false
  end
  return true
end

function CRoleMove:Unmarshal(buffer)
  local ret = true
  ret, self.sceneid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.position:Unmarshal(buffer) then
    return false
  end
  return ret
end

return CRoleMove
