local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SStartGuide = dataclass("SStartGuide", require("framework.net.protocol"))
SStartGuide.ProtocolType = 2213
SStartGuide.MaxSize = 65535
SStartGuide.guide = 0

function SStartGuide:Ctor(client)
  SStartGuide.super.Ctor(self, client)
end

function SStartGuide:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.guide) then
    return false
  end
  return true
end

function SStartGuide:Unmarshal(buffer)
  local ret = true
  ret, self.guide = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SStartGuide
