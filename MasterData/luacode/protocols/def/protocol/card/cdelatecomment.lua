local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDelateComment = dataclass("CDelateComment", require("framework.net.protocol"))
CDelateComment.ProtocolType = 1517
CDelateComment.MaxSize = 65535
CDelateComment.commentKey = 0
CDelateComment.roleid = 0
CDelateComment.page = 0

function CDelateComment:Ctor(client)
  CDelateComment.super.Ctor(self, client)
end

function CDelateComment:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.commentKey) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.page) then
    return false
  end
  return true
end

function CDelateComment:Unmarshal(buffer)
  local ret = true
  ret, self.commentKey = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.roleid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.page = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDelateComment
