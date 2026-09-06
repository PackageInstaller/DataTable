local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ChatBean = dataclass("ChatBean", require("framework.net.protocol"))
ChatBean.ProtocolType = 1101
ChatBean.MaxSize = 65535

function ChatBean:Ctor(client)
  ChatBean.super.Ctor(self, client)
  self.b1 = require("protocols.bean.protocol.chat.channeltype").Create()
end

function ChatBean:Marshal(buffer)
  if not self.b1:Marshal(buffer) then
    return false
  end
  return true
end

function ChatBean:Unmarshal(buffer)
  local ret = true
  if not self.b1:Unmarshal(buffer) then
    return false
  end
  return ret
end

return ChatBean
