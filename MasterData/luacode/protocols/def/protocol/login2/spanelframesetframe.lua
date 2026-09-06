local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPanelFrameSetFrame = dataclass("SPanelFrameSetFrame", require("framework.net.protocol"))
SPanelFrameSetFrame.ProtocolType = 5204
SPanelFrameSetFrame.MaxSize = 65535
SPanelFrameSetFrame.curPanelFrame = 0

function SPanelFrameSetFrame:Ctor(client)
  SPanelFrameSetFrame.super.Ctor(self, client)
end

function SPanelFrameSetFrame:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.curPanelFrame) then
    return false
  end
  return true
end

function SPanelFrameSetFrame:Unmarshal(buffer)
  local ret = true
  ret, self.curPanelFrame = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SPanelFrameSetFrame
