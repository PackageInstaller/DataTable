local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUnlockPuzzle = dataclass("SUnlockPuzzle", require("framework.net.protocol"))
SUnlockPuzzle.ProtocolType = 2496
SUnlockPuzzle.MaxSize = 65535
SUnlockPuzzle.activityId = 0
SUnlockPuzzle.puzzleId = 0
SUnlockPuzzle.puzzleNum = 0

function SUnlockPuzzle:Ctor(client)
  SUnlockPuzzle.super.Ctor(self, client)
end

function SUnlockPuzzle:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.puzzleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.puzzleNum) then
    return false
  end
  return true
end

function SUnlockPuzzle:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.puzzleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.puzzleNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUnlockPuzzle
