local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLikeComment = dataclass("SLikeComment", require("framework.net.protocol"))
SLikeComment.ProtocolType = 1520
SLikeComment.MaxSize = 65535
SLikeComment.key = 0
SLikeComment.reply = 0
SLikeComment.likes = 0

function SLikeComment:Ctor(client)
  SLikeComment.super.Ctor(self, client)
end

function SLikeComment:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.key) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.reply) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.likes) then
    return false
  end
  return true
end

function SLikeComment:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.reply = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.likes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLikeComment
