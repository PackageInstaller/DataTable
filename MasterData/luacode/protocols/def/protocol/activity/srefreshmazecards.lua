local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshMazeCards = dataclass("SRefreshMazeCards", require("framework.net.protocol"))
SRefreshMazeCards.ProtocolType = 2687
SRefreshMazeCards.MaxSize = 65535

function SRefreshMazeCards:Ctor(client)
  SRefreshMazeCards.super.Ctor(self, client)
  self.cards = {}
end

function SRefreshMazeCards:Marshal(buffer)
  local length = table.slen(self.cards)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.cards[i]) then
      return false
    end
  end
  return true
end

function SRefreshMazeCards:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.cards[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SRefreshMazeCards
