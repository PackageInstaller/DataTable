local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRoleList = dataclass("CRoleList", require("framework.net.protocol"))
CRoleList.ProtocolType = 1010
CRoleList.MaxSize = 65535

function CRoleList:Ctor(client)
  CRoleList.super.Ctor(self, client)
end

function CRoleList:Marshal(buffer)
  return true
end

function CRoleList:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRoleList
