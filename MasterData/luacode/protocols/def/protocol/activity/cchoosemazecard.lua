local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChooseMazeCard = dataclass("CChooseMazeCard", require("framework.net.protocol"))
CChooseMazeCard.ProtocolType = 2688
CChooseMazeCard.MaxSize = 65535
CChooseMazeCard.card = 0

function CChooseMazeCard:Ctor(client)
  CChooseMazeCard.super.Ctor(self, client)
end

function CChooseMazeCard:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.card) then
    return false
  end
  return true
end

function CChooseMazeCard:Unmarshal(buffer)
  local ret = true
  ret, self.card = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChooseMazeCard
