local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUnlockBpPuzzle = dataclass("CUnlockBpPuzzle", require("framework.net.protocol"))
CUnlockBpPuzzle.ProtocolType = 2673
CUnlockBpPuzzle.MaxSize = 65535
CUnlockBpPuzzle.puzzleId = 0

function CUnlockBpPuzzle:Ctor(client)
  CUnlockBpPuzzle.super.Ctor(self, client)
end

function CUnlockBpPuzzle:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.puzzleId) then
    return false
  end
  return true
end

function CUnlockBpPuzzle:Unmarshal(buffer)
  local ret = true
  ret, self.puzzleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUnlockBpPuzzle
