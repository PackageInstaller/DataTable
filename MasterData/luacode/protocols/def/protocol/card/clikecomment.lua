local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CLikeComment = dataclass("CLikeComment", require("framework.net.protocol"))
CLikeComment.ProtocolType = 1519
CLikeComment.MaxSize = 65535
CLikeComment.commentKey = 0
CLikeComment.roleId = 0
CLikeComment.operate = 0
CLikeComment.LIKE = 1
CLikeComment.DISLIKE = 2

function CLikeComment:Ctor(client)
  CLikeComment.super.Ctor(self, client)
end

function CLikeComment:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.commentKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.operate) then
    return false
  end
  return true
end

function CLikeComment:Unmarshal(buffer)
  local ret = true
  ret, self.commentKey = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.operate = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLikeComment
