local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshTrainRoom = dataclass("SRefreshTrainRoom", require("framework.net.protocol"))
SRefreshTrainRoom.ProtocolType = 2378
SRefreshTrainRoom.MaxSize = 65535

function SRefreshTrainRoom:Ctor(client)
  SRefreshTrainRoom.super.Ctor(self, client)
  self.room = require("protocols.bean.protocol.yard.trainroom").Create()
end

function SRefreshTrainRoom:Marshal(buffer)
  if not self.room:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshTrainRoom:Unmarshal(buffer)
  local ret = true
  if not self.room:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshTrainRoom
