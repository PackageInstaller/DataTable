local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPanelFrameGetInfo = dataclass("SPanelFrameGetInfo", require("framework.net.protocol"))
SPanelFrameGetInfo.ProtocolType = 5202
SPanelFrameGetInfo.MaxSize = 65535
SPanelFrameGetInfo.curPanelFrame = 0

function SPanelFrameGetInfo:Ctor(client)
  SPanelFrameGetInfo.super.Ctor(self, client)
  self.had = {}
end

function SPanelFrameGetInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.curPanelFrame) then
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

function SPanelFrameGetInfo:Unmarshal(buffer)
  local ret = true
  ret, self.curPanelFrame = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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

return SPanelFrameGetInfo
