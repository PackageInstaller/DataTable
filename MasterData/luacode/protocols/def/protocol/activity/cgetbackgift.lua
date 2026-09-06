local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetBackGift = dataclass("CGetBackGift", require("framework.net.protocol"))
CGetBackGift.ProtocolType = 2557
CGetBackGift.MaxSize = 65535
CGetBackGift.goodId = 0

function CGetBackGift:Ctor(client)
  CGetBackGift.super.Ctor(self, client)
end

function CGetBackGift:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.goodId) then
    return false
  end
  return true
end

function CGetBackGift:Unmarshal(buffer)
  local ret = true
  ret, self.goodId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetBackGift
