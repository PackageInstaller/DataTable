local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUnlockBpPuzzle = dataclass("SUnlockBpPuzzle", require("framework.net.protocol"))
SUnlockBpPuzzle.ProtocolType = 2674
SUnlockBpPuzzle.MaxSize = 65535
SUnlockBpPuzzle.puzzleId = 0

function SUnlockBpPuzzle:Ctor(client)
  SUnlockBpPuzzle.super.Ctor(self, client)
end

function SUnlockBpPuzzle:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.puzzleId) then
    return false
  end
  return true
end

function SUnlockBpPuzzle:Unmarshal(buffer)
  local ret = true
  ret, self.puzzleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUnlockBpPuzzle
