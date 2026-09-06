local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCommitQuest = dataclass("CCommitQuest", require("framework.net.protocol"))
CCommitQuest.ProtocolType = 1414
CCommitQuest.MaxSize = 65535
CCommitQuest.uniqueId = 0
CCommitQuest.answer = ""
CCommitQuest.validate = 0

function CCommitQuest:Ctor(client)
  CCommitQuest.super.Ctor(self, client)
end

function CCommitQuest:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.uniqueId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.answer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteByte(buffer, self.validate) then
    return false
  end
  return true
end

function CCommitQuest:Unmarshal(buffer)
  local ret = true
  ret, self.uniqueId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.answer = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.validate = ProtocolBufferStaticFunctions.ReadByte(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCommitQuest
