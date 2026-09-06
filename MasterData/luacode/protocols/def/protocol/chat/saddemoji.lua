local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAddEmoji = dataclass("SAddEmoji", require("framework.net.protocol"))
SAddEmoji.ProtocolType = 1167
SAddEmoji.MaxSize = 65535
SAddEmoji.eomjiId = 0

function SAddEmoji:Ctor(client)
  SAddEmoji.super.Ctor(self, client)
end

function SAddEmoji:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.eomjiId) then
    return false
  end
  return true
end

function SAddEmoji:Unmarshal(buffer)
  local ret = true
  ret, self.eomjiId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAddEmoji
