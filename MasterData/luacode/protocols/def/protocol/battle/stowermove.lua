local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local STowerMove = dataclass("STowerMove", require("framework.net.protocol"))
STowerMove.ProtocolType = 1987
STowerMove.MaxSize = 65535
STowerMove.nextIsland = 0

function STowerMove:Ctor(client)
  STowerMove.super.Ctor(self, client)
end

function STowerMove:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.nextIsland) then
    return false
  end
  return true
end

function STowerMove:Unmarshal(buffer)
  local ret = true
  ret, self.nextIsland = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return STowerMove
