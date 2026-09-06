local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRougeTowerChoiceBuff = dataclass("SRougeTowerChoiceBuff", require("framework.net.protocol"))
SRougeTowerChoiceBuff.ProtocolType = 2449
SRougeTowerChoiceBuff.MaxSize = 65535
SRougeTowerChoiceBuff.pointID = 0
SRougeTowerChoiceBuff.choiceBuff = 0
SRougeTowerChoiceBuff.choiceResult = 0

function SRougeTowerChoiceBuff:Ctor(client)
  SRougeTowerChoiceBuff.super.Ctor(self, client)
end

function SRougeTowerChoiceBuff:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pointID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.choiceBuff) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.choiceResult) then
    return false
  end
  return true
end

function SRougeTowerChoiceBuff:Unmarshal(buffer)
  local ret = true
  ret, self.pointID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.choiceBuff = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.choiceResult = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRougeTowerChoiceBuff
