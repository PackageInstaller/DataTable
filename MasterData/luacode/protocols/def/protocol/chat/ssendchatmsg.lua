local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendChatMsg = dataclass("SSendChatMsg", require("framework.net.protocol"))
SSendChatMsg.ProtocolType = 1103
SSendChatMsg.MaxSize = 65535
SSendChatMsg.channelType = 0
SSendChatMsg.msg = ""
SSendChatMsg.severId = 0
SSendChatMsg.bubbleID = 0

function SSendChatMsg:Ctor(client)
  SSendChatMsg.super.Ctor(self, client)
  self.baseUserData = require("protocols.bean.protocol.chat.baseuserdata").Create()
  self.hyperlinks = {}
end

function SSendChatMsg:Marshal(buffer)
  if not self.baseUserData:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.channelType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.msg) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.severId) then
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bubbleID) then
    return false
  end
  return true
end

function SSendChatMsg:Unmarshal(buffer)
  local ret = true
  if not self.baseUserData:Unmarshal(buffer) then
    return false
  end
  ret, self.channelType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.msg = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.severId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  ret, self.bubbleID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendChatMsg
