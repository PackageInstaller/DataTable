local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CNewComment = dataclass("CNewComment", require("framework.net.protocol"))
CNewComment.ProtocolType = 1515
CNewComment.MaxSize = 65535
CNewComment.roleId = 0
CNewComment.comment = ""

function CNewComment:Ctor(client)
  CNewComment.super.Ctor(self, client)
end

function CNewComment:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.comment) then
    return false
  end
  return true
end

function CNewComment:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.comment = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CNewComment
