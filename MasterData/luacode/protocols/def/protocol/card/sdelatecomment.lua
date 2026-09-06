local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDelateComment = dataclass("SDelateComment", require("framework.net.protocol"))
SDelateComment.ProtocolType = 1518
SDelateComment.MaxSize = 65535
SDelateComment.result = 0

function SDelateComment:Ctor(client)
  SDelateComment.super.Ctor(self, client)
end

function SDelateComment:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SDelateComment:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SDelateComment
