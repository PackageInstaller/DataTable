local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChatBubbleSetBubble = dataclass("CChatBubbleSetBubble", require("framework.net.protocol"))
CChatBubbleSetBubble.ProtocolType = 1173
CChatBubbleSetBubble.MaxSize = 65535
CChatBubbleSetBubble.bubbleID = 0

function CChatBubbleSetBubble:Ctor(client)
  CChatBubbleSetBubble.super.Ctor(self, client)
end

function CChatBubbleSetBubble:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bubbleID) then
    return false
  end
  return true
end

function CChatBubbleSetBubble:Unmarshal(buffer)
  local ret = true
  ret, self.bubbleID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChatBubbleSetBubble
