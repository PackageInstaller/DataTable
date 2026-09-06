local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRemoveRepairRoles = dataclass("SRemoveRepairRoles", require("framework.net.protocol"))
SRemoveRepairRoles.ProtocolType = 1053
SRemoveRepairRoles.MaxSize = 65535

function SRemoveRepairRoles:Ctor(client)
  SRemoveRepairRoles.super.Ctor(self, client)
  self.deadRoles = {}
end

function SRemoveRepairRoles:Marshal(buffer)
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

function SRemoveRepairRoles:Unmarshal(buffer)
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

return SRemoveRepairRoles
