local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CommentInfo = dataclass("CommentInfo")
CommentInfo.selfLike = 0

function CommentInfo:Ctor()
  self.baseInfo = require("protocols.bean.protocol.card.commentbaseinfo").Create()
end

function CommentInfo:Marshal(buffer)
  if not self.baseInfo:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.selfLike) then
    return false
  end
  return true
end

function CommentInfo:Unmarshal(buffer)
  local ret = true
  if not self.baseInfo:Unmarshal(buffer) then
    return false
  end
  ret, self.selfLike = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CommentInfo
