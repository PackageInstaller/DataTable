local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendPartyMsg = dataclass("SSendPartyMsg", require("framework.net.protocol"))
SSendPartyMsg.ProtocolType = 1153
SSendPartyMsg.MaxSize = 65535

function SSendPartyMsg:Ctor(client)
  SSendPartyMsg.super.Ctor(self, client)
  self.msgInfo = require("protocols.bean.protocol.chat.msginfo").Create()
end

function SSendPartyMsg:Marshal(buffer)
  if not self.msgInfo:Marshal(buffer) then
    return false
  end
  return true
end

function SSendPartyMsg:Unmarshal(buffer)
  local ret = true
  if not self.msgInfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SSendPartyMsg
