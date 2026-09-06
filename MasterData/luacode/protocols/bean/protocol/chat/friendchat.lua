local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local FriendChat = dataclass("FriendChat")
FriendChat.msg = ""
FriendChat.time = 0
FriendChat.bubbleID = 0

function FriendChat:Ctor()
  self.hyperlinks = {}
end

function FriendChat:Marshal(buffer)
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
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.time) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bubbleID) then
    return false
  end
  return true
end

function FriendChat:Unmarshal(buffer)
  local ret = true
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
  ret, self.time = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.bubbleID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return FriendChat
