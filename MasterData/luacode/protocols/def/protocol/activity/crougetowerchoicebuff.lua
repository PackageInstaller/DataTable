local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRougeTowerChoiceBuff = dataclass("CRougeTowerChoiceBuff", require("framework.net.protocol"))
CRougeTowerChoiceBuff.ProtocolType = 2448
CRougeTowerChoiceBuff.MaxSize = 65535
CRougeTowerChoiceBuff.pointID = 0
CRougeTowerChoiceBuff.buffChoice = 0

function CRougeTowerChoiceBuff:Ctor(client)
  CRougeTowerChoiceBuff.super.Ctor(self, client)
end

function CRougeTowerChoiceBuff:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.pointID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.buffChoice) then
    return false
  end
  return true
end

function CRougeTowerChoiceBuff:Unmarshal(buffer)
  local ret = true
  ret, self.pointID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.buffChoice = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRougeTowerChoiceBuff
