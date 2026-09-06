local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetComments = dataclass("CGetComments", require("framework.net.protocol"))
CGetComments.ProtocolType = 1512
CGetComments.MaxSize = 65535
CGetComments.roleId = 0
CGetComments.commentType = 0
CGetComments.lastIndex = 0
CGetComments.POPULAR_COMMENT = 1
CGetComments.LATEST_COMMENT = 2
CGetComments.COMMENTS_PRE_PAGE = 30

function CGetComments:Ctor(client)
  CGetComments.super.Ctor(self, client)
end

function CGetComments:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.commentType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lastIndex) then
    return false
  end
  return true
end

function CGetComments:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.commentType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.lastIndex = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetComments
