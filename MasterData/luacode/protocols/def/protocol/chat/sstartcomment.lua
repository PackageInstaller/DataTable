local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SStartComment = dataclass("SStartComment", require("framework.net.protocol"))
SStartComment.ProtocolType = 1149
SStartComment.MaxSize = 65535
SStartComment.logType = 0
SStartComment.awardId = 0

function SStartComment:Ctor(client)
  SStartComment.super.Ctor(self, client)
end

function SStartComment:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.logType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.awardId) then
    return false
  end
  return true
end

function SStartComment:Unmarshal(buffer)
  local ret = true
  ret, self.logType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.awardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SStartComment
