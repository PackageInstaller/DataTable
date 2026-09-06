local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeWish = dataclass("CChangeWish", require("framework.net.protocol"))
CChangeWish.ProtocolType = 2543
CChangeWish.MaxSize = 65535
CChangeWish.index = 0

function CChangeWish:Ctor(client)
  CChangeWish.super.Ctor(self, client)
end

function CChangeWish:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  return true
end

function CChangeWish:Unmarshal(buffer)
  local ret = true
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeWish
