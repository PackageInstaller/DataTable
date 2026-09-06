local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SNewComment = dataclass("SNewComment", require("framework.net.protocol"))
SNewComment.ProtocolType = 1516
SNewComment.MaxSize = 65535
SNewComment.result = 0

function SNewComment:Ctor(client)
  SNewComment.super.Ctor(self, client)
  self.userComment = require("protocols.bean.protocol.card.commentinfo").Create()
end

function SNewComment:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not self.userComment:Marshal(buffer) then
    return false
  end
  return true
end

function SNewComment:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.userComment:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SNewComment
