local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshRoom = dataclass("SRefreshRoom", require("framework.net.protocol"))
SRefreshRoom.ProtocolType = 2358
SRefreshRoom.MaxSize = 65535

function SRefreshRoom:Ctor(client)
  SRefreshRoom.super.Ctor(self, client)
  self.room = require("protocols.bean.protocol.yard.witchroom").Create()
end

function SRefreshRoom:Marshal(buffer)
  if not self.room:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshRoom:Unmarshal(buffer)
  local ret = true
  if not self.room:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshRoom
