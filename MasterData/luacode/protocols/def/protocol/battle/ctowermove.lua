local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CTowerMove = dataclass("CTowerMove", require("framework.net.protocol"))
CTowerMove.ProtocolType = 1974
CTowerMove.MaxSize = 65535
CTowerMove.nextIsland = 0

function CTowerMove:Ctor(client)
  CTowerMove.super.Ctor(self, client)
end

function CTowerMove:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.nextIsland) then
    return false
  end
  return true
end

function CTowerMove:Unmarshal(buffer)
  local ret = true
  ret, self.nextIsland = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CTowerMove
