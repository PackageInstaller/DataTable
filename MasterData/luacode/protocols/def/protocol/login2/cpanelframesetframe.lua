local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CPanelFrameSetFrame = dataclass("CPanelFrameSetFrame", require("framework.net.protocol"))
CPanelFrameSetFrame.ProtocolType = 5203
CPanelFrameSetFrame.MaxSize = 65535
CPanelFrameSetFrame.curPanelFrame = 0

function CPanelFrameSetFrame:Ctor(client)
  CPanelFrameSetFrame.super.Ctor(self, client)
end

function CPanelFrameSetFrame:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.curPanelFrame) then
    return false
  end
  return true
end

function CPanelFrameSetFrame:Unmarshal(buffer)
  local ret = true
  ret, self.curPanelFrame = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CPanelFrameSetFrame
