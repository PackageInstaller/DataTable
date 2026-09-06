local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SItemConvertToFrame = dataclass("SItemConvertToFrame", require("framework.net.protocol"))
SItemConvertToFrame.ProtocolType = 2263
SItemConvertToFrame.MaxSize = 65535
SItemConvertToFrame.frameId = 0

function SItemConvertToFrame:Ctor(client)
  SItemConvertToFrame.super.Ctor(self, client)
end

function SItemConvertToFrame:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.frameId) then
    return false
  end
  return true
end

function SItemConvertToFrame:Unmarshal(buffer)
  local ret = true
  ret, self.frameId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SItemConvertToFrame
