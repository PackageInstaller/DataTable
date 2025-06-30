-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/card/commentinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CommentInfo = dataclass("CommentInfo")
CommentInfo.selfLike = 0
CommentInfo.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.baseInfo = ((require("protocols.bean.protocol.card.commentbaseinfo")).Create)()
end

CommentInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (self.baseInfo):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.selfLike) then
    return false
  end
  return true
end

CommentInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  if not (self.baseInfo):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CommentInfo

