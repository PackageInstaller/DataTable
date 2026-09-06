local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChatBubbleSetBubble = dataclass("SChatBubbleSetBubble", require("framework.net.protocol"))
SChatBubbleSetBubble.ProtocolType = 1174
SChatBubbleSetBubble.MaxSize = 65535
SChatBubbleSetBubble.curBubble = 0

function SChatBubbleSetBubble:Ctor(client)
  SChatBubbleSetBubble.super.Ctor(self, client)
end

function SChatBubbleSetBubble:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.curBubble) then
    return false
  end
  return true
end

function SChatBubbleSetBubble:Unmarshal(buffer)
  local ret = true
  ret, self.curBubble = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChatBubbleSetBubble
