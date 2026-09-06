local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChatBubbleGetInfo = dataclass("CChatBubbleGetInfo", require("framework.net.protocol"))
CChatBubbleGetInfo.ProtocolType = 1171
CChatBubbleGetInfo.MaxSize = 65535

function CChatBubbleGetInfo:Ctor(client)
  CChatBubbleGetInfo.super.Ctor(self, client)
end

function CChatBubbleGetInfo:Marshal(buffer)
  return true
end

function CChatBubbleGetInfo:Unmarshal(buffer)
  local ret = true
  return ret
end

return CChatBubbleGetInfo
