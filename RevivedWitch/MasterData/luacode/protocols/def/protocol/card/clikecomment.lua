-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/clikecomment.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CLikeComment = dataclass("CLikeComment", require("framework.net.protocol"))
CLikeComment.ProtocolType = 1519
CLikeComment.MaxSize = 65535
CLikeComment.commentKey = 0
CLikeComment.roleId = 0
CLikeComment.operate = 0
CLikeComment.LIKE = 1
CLikeComment.DISLIKE = 2
CLikeComment.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CLikeComment
  ((CLikeComment.super).Ctor)(self, client)
end

CLikeComment.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.commentKey) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.operate) then
    return false
  end
  return true
end

CLikeComment.Unmarshal = function(self, buffer)
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

return CLikeComment

