local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCompleteComment = dataclass("SCompleteComment", require("framework.net.protocol"))
SCompleteComment.ProtocolType = 1151
SCompleteComment.MaxSize = 65535

function SCompleteComment:Ctor(client)
  SCompleteComment.super.Ctor(self, client)
end

function SCompleteComment:Marshal(buffer)
  return true
end

function SCompleteComment:Unmarshal(buffer)
  local ret = true
  return ret
end

return SCompleteComment
