local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CQuickRepairRoles = dataclass("CQuickRepairRoles", require("framework.net.protocol"))
CQuickRepairRoles.ProtocolType = 1054
CQuickRepairRoles.MaxSize = 65535

function CQuickRepairRoles:Ctor(client)
  CQuickRepairRoles.super.Ctor(self, client)
  self.roleIds = {}
end

function CQuickRepairRoles:Marshal(buffer)
  local length = table.slen(self.roleIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleIds[i]) then
      return false
    end
  end
  return true
end

function CQuickRepairRoles:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.roleIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CQuickRepairRoles
