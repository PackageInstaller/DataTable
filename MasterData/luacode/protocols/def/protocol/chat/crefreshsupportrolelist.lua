local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRefreshSupportRoleList = dataclass("CRefreshSupportRoleList", require("framework.net.protocol"))
CRefreshSupportRoleList.ProtocolType = 1145
CRefreshSupportRoleList.MaxSize = 65535

function CRefreshSupportRoleList:Ctor(client)
  CRefreshSupportRoleList.super.Ctor(self, client)
end

function CRefreshSupportRoleList:Marshal(buffer)
  return true
end

function CRefreshSupportRoleList:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRefreshSupportRoleList
