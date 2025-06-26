-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/slikecomment.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLikeComment = dataclass("SLikeComment", require("framework.net.protocol"))
SLikeComment.ProtocolType = 1520
SLikeComment.MaxSize = 65535
SLikeComment.key = 0
SLikeComment.reply = 0
SLikeComment.likes = 0
SLikeComment.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLikeComment
  ((SLikeComment.super).Ctor)(self, client)
end

SLikeComment.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.key) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.reply) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.likes) then
    return false
  end
  return true
end

SLikeComment.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLikeComment

