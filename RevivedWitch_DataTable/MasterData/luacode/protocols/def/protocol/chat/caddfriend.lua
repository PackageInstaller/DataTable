-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/caddfriend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAddFriend = dataclass("CAddFriend", require("framework.net.protocol"))
CAddFriend.ProtocolType = 1124
CAddFriend.MaxSize = 65535
CAddFriend.userId = 0
CAddFriend.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAddFriend
  ((CAddFriend.super).Ctor)(self, client)
end

CAddFriend.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  return true
end

CAddFriend.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAddFriend

