local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeWish = dataclass("SChangeWish", require("framework.net.protocol"))
SChangeWish.ProtocolType = 2544
SChangeWish.MaxSize = 65535
SChangeWish.index = 0

function SChangeWish:Ctor(client)
  SChangeWish.super.Ctor(self, client)
end

function SChangeWish:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  return true
end

function SChangeWish:Unmarshal(buffer)
  local ret = true
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeWish
