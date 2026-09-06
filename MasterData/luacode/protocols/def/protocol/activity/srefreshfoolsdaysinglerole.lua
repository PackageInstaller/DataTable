local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshFoolsDaySingleRole = dataclass("SRefreshFoolsDaySingleRole", require("framework.net.protocol"))
SRefreshFoolsDaySingleRole.ProtocolType = 2631
SRefreshFoolsDaySingleRole.MaxSize = 65535

function SRefreshFoolsDaySingleRole:Ctor(client)
  SRefreshFoolsDaySingleRole.super.Ctor(self, client)
  self.role = require("protocols.bean.protocol.activity.foolsdayrole").Create()
end

function SRefreshFoolsDaySingleRole:Marshal(buffer)
  if not self.role:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshFoolsDaySingleRole:Unmarshal(buffer)
  local ret = true
  if not self.role:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshFoolsDaySingleRole
