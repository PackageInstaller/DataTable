local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSendChatMsg = dataclass("CSendChatMsg", require("framework.net.protocol"))
CSendChatMsg.ProtocolType = 1102
CSendChatMsg.MaxSize = 65535
CSendChatMsg.channelType = 0
CSendChatMsg.msg = ""

function CSendChatMsg:Ctor(client)
  CSendChatMsg.super.Ctor(self, client)
  self.hyperlinks = {}
end

function CSendChatMsg:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.channelType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.msg) then
    return false
  end
  local length = table.slen(self.hyperlinks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.hyperlinks[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function CSendChatMsg:Unmarshal(buffer)
  local ret = true
  ret, self.channelType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.msg = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.hyperlinks[i] = require("protocols.bean.protocol.chat.hyperlink").Create()
    if not self.hyperlinks[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return CSendChatMsg
