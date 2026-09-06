local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendHistoryChatMsg = dataclass("SSendHistoryChatMsg", require("framework.net.protocol"))
SSendHistoryChatMsg.ProtocolType = 1154
SSendHistoryChatMsg.MaxSize = 65535

function SSendHistoryChatMsg:Ctor(client)
  SSendHistoryChatMsg.super.Ctor(self, client)
  self.msgInfo = {}
end

function SSendHistoryChatMsg:Marshal(buffer)
  local length = table.slen(self.msgInfo)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.msgInfo[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SSendHistoryChatMsg:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.msgInfo[i] = require("protocols.bean.protocol.chat.msginfo").Create()
    if not self.msgInfo[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SSendHistoryChatMsg
