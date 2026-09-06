local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendEmojiInfo = dataclass("SSendEmojiInfo", require("framework.net.protocol"))
SSendEmojiInfo.ProtocolType = 1166
SSendEmojiInfo.MaxSize = 65535

function SSendEmojiInfo:Ctor(client)
  SSendEmojiInfo.super.Ctor(self, client)
  self.hadEmoji = {}
end

function SSendEmojiInfo:Marshal(buffer)
  local length = table.slen(self.hadEmoji)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.hadEmoji[i]) then
      return false
    end
  end
  return true
end

function SSendEmojiInfo:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.hadEmoji[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SSendEmojiInfo
