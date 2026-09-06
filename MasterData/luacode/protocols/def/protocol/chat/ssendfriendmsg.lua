local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendFriendMsg = dataclass("SSendFriendMsg", require("framework.net.protocol"))
SSendFriendMsg.ProtocolType = 1132
SSendFriendMsg.MaxSize = 65535
SSendFriendMsg.userId = 0
SSendFriendMsg.spokesman = 0

function SSendFriendMsg:Ctor(client)
  SSendFriendMsg.super.Ctor(self, client)
  self.msg = require("protocols.bean.protocol.chat.friendchat").Create()
end

function SSendFriendMsg:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.spokesman) then
    return false
  end
  if not self.msg:Marshal(buffer) then
    return false
  end
  return true
end

function SSendFriendMsg:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.spokesman = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.msg:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SSendFriendMsg
