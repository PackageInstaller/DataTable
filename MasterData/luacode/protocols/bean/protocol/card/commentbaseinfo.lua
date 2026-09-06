local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CommentBaseInfo = dataclass("CommentBaseInfo")
CommentBaseInfo.userId = 0
CommentBaseInfo.userName = ""
CommentBaseInfo.userAvatarId = 0
CommentBaseInfo.userFrameId = 0
CommentBaseInfo.key = 0
CommentBaseInfo.page = 0
CommentBaseInfo.likes = 0
CommentBaseInfo.time = 0
CommentBaseInfo.comment = ""

function CommentBaseInfo:Ctor()
end

function CommentBaseInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.userName) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.userAvatarId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.userFrameId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.key) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.page) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.likes) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.time) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.comment) then
    return false
  end
  return true
end

function CommentBaseInfo:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.userName = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.userAvatarId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.userFrameId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.page = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.likes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.time = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.comment = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CommentBaseInfo
