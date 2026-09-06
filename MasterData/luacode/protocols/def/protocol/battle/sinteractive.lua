local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SInterActive = dataclass("SInterActive", require("framework.net.protocol"))
SInterActive.ProtocolType = 1969
SInterActive.MaxSize = 65535

function SInterActive:Ctor(client)
  SInterActive.super.Ctor(self, client)
  self.obj = require("protocols.bean.protocol.battle.interactiveobj").Create()
end

function SInterActive:Marshal(buffer)
  if not self.obj:Marshal(buffer) then
    return false
  end
  return true
end

function SInterActive:Unmarshal(buffer)
  local ret = true
  if not self.obj:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SInterActive
