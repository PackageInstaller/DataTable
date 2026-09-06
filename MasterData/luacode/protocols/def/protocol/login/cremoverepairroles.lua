local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRemoveRepairRoles = dataclass("CRemoveRepairRoles", require("framework.net.protocol"))
CRemoveRepairRoles.ProtocolType = 1055
CRemoveRepairRoles.MaxSize = 65535

function CRemoveRepairRoles:Ctor(client)
  CRemoveRepairRoles.super.Ctor(self, client)
end

function CRemoveRepairRoles:Marshal(buffer)
  return true
end

function CRemoveRepairRoles:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRemoveRepairRoles
