local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SYardInfo = dataclass("SYardInfo", require("framework.net.protocol"))
SYardInfo.ProtocolType = 2301
SYardInfo.MaxSize = 65535

function SYardInfo:Ctor(client)
  SYardInfo.super.Ctor(self, client)
  self.magicTree = require("protocols.bean.protocol.yard.magictree").Create()
  self.cavern = require("protocols.bean.protocol.yard.cavern").Create()
  self.lampStand = require("protocols.bean.protocol.yard.lampstand").Create()
  self.alchemy = require("protocols.bean.protocol.yard.alchemy").Create()
  self.room = require("protocols.bean.protocol.yard.witchroom").Create()
  self.trainRoom = require("protocols.bean.protocol.yard.trainroom").Create()
  self.music = require("protocols.bean.protocol.yard.music").Create()
end

function SYardInfo:Marshal(buffer)
  if not self.magicTree:Marshal(buffer) then
    return false
  end
  if not self.cavern:Marshal(buffer) then
    return false
  end
  if not self.lampStand:Marshal(buffer) then
    return false
  end
  if not self.alchemy:Marshal(buffer) then
    return false
  end
  if not self.room:Marshal(buffer) then
    return false
  end
  if not self.trainRoom:Marshal(buffer) then
    return false
  end
  if not self.music:Marshal(buffer) then
    return false
  end
  return true
end

function SYardInfo:Unmarshal(buffer)
  local ret = true
  if not self.magicTree:Unmarshal(buffer) then
    return false
  end
  if not self.cavern:Unmarshal(buffer) then
    return false
  end
  if not self.lampStand:Unmarshal(buffer) then
    return false
  end
  if not self.alchemy:Unmarshal(buffer) then
    return false
  end
  if not self.room:Unmarshal(buffer) then
    return false
  end
  if not self.trainRoom:Unmarshal(buffer) then
    return false
  end
  if not self.music:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SYardInfo
