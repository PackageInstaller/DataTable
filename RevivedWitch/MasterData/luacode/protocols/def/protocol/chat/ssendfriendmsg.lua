-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/ssendfriendmsg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendFriendMsg = dataclass("SSendFriendMsg", require("framework.net.protocol"))
SSendFriendMsg.ProtocolType = 1132
SSendFriendMsg.MaxSize = 65535
SSendFriendMsg.userId = 0
SSendFriendMsg.spokesman = 0
SSendFriendMsg.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendFriendMsg, _ENV
  ((SSendFriendMsg.super).Ctor)(self, client)
  self.msg = ((require("protocols.bean.protocol.chat.friendchat")).Create)()
end

SSendFriendMsg.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.spokesman) then
    return false
  end
  if not (self.msg):Marshal(buffer) then
    return false
  end
  return true
end

SSendFriendMsg.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.msg):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SSendFriendMsg

