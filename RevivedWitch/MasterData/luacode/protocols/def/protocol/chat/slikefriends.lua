-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/slikefriends.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLikeFriends = dataclass("SLikeFriends", require("framework.net.protocol"))
SLikeFriends.ProtocolType = 1139
SLikeFriends.MaxSize = 65535
SLikeFriends.userId = 0
SLikeFriends.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLikeFriends
  ((SLikeFriends.super).Ctor)(self, client)
end

SLikeFriends.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  return true
end

SLikeFriends.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLikeFriends

