local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAddDeadRoles = dataclass("SAddDeadRoles", require("framework.net.protocol"))
SAddDeadRoles.ProtocolType = 1052
SAddDeadRoles.MaxSize = 65535

function SAddDeadRoles:Ctor(client)
  SAddDeadRoles.super.Ctor(self, client)
  self.deadRoles = {}
end

function SAddDeadRoles:Marshal(buffer)
  local length = table.slen(self.deadRoles)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.deadRoles[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SAddDeadRoles:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.deadRoles[i] = require("protocols.bean.protocol.login.deadrole").Create()
    if not self.deadRoles[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SAddDeadRoles
