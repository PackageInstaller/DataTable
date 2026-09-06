local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCompleteComment = dataclass("CCompleteComment", require("framework.net.protocol"))
CCompleteComment.ProtocolType = 1150
CCompleteComment.MaxSize = 65535
CCompleteComment.logResult = 0
CCompleteComment.logType = 0
CCompleteComment.content = ""
CCompleteComment.ADVICE = 1
CCompleteComment.AWARD = 2
CCompleteComment.CANCEL = 3
CCompleteComment.SURE_DRAW = 1
CCompleteComment.ACTIVE = 2
CCompleteComment.MISSION = 3
CCompleteComment.FIRST_LUCK = 4

function CCompleteComment:Ctor(client)
  CCompleteComment.super.Ctor(self, client)
end

function CCompleteComment:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.logResult) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.logType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.content) then
    return false
  end
  return true
end

function CCompleteComment:Unmarshal(buffer)
  local ret = true
  ret, self.logResult = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.logType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.content = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCompleteComment
