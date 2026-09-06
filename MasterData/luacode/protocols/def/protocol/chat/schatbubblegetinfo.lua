local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChatBubbleGetInfo = dataclass("SChatBubbleGetInfo", require("framework.net.protocol"))
SChatBubbleGetInfo.ProtocolType = 1172
SChatBubbleGetInfo.MaxSize = 65535
SChatBubbleGetInfo.curBubble = 0

function SChatBubbleGetInfo:Ctor(client)
  SChatBubbleGetInfo.super.Ctor(self, client)
  self.had = {}
end

function SChatBubbleGetInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.curBubble) then
    return false
  end
  local length = table.slen(self.had)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.had[i]) then
      return false
    end
  end
  return true
end

function SChatBubbleGetInfo:Unmarshal(buffer)
  local ret = true
  ret, self.curBubble = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.had[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SChatBubbleGetInfo
