-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/snewcomment.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SNewComment = dataclass("SNewComment", require("framework.net.protocol"))
SNewComment.ProtocolType = 1516
SNewComment.MaxSize = 65535
SNewComment.result = 0
SNewComment.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SNewComment, _ENV
  ((SNewComment.super).Ctor)(self, client)
  self.userComment = ((require("protocols.bean.protocol.card.commentinfo")).Create)()
end

SNewComment.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (self.userComment):Marshal(buffer) then
    return false
  end
  return true
end

SNewComment.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.userComment):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SNewComment

