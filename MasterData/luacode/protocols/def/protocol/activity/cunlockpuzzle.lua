local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUnlockPuzzle = dataclass("CUnlockPuzzle", require("framework.net.protocol"))
CUnlockPuzzle.ProtocolType = 2495
CUnlockPuzzle.MaxSize = 65535
CUnlockPuzzle.activityId = 0
CUnlockPuzzle.puzzleId = 0

function CUnlockPuzzle:Ctor(client)
  CUnlockPuzzle.super.Ctor(self, client)
end

function CUnlockPuzzle:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.puzzleId) then
    return false
  end
  return true
end

function CUnlockPuzzle:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.puzzleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUnlockPuzzle
