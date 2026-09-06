local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeUserLikedNum = dataclass("SChangeUserLikedNum", require("framework.net.protocol"))
SChangeUserLikedNum.ProtocolType = 2229
SChangeUserLikedNum.MaxSize = 65535
SChangeUserLikedNum.likedNum = 0

function SChangeUserLikedNum:Ctor(client)
  SChangeUserLikedNum.super.Ctor(self, client)
end

function SChangeUserLikedNum:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.likedNum) then
    return false
  end
  return true
end

function SChangeUserLikedNum:Unmarshal(buffer)
  local ret = true
  ret, self.likedNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeUserLikedNum
