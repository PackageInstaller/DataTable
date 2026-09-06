local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDustSynthesis = dataclass("CDustSynthesis", require("framework.net.protocol"))
CDustSynthesis.ProtocolType = 1099
CDustSynthesis.MaxSize = 65535
CDustSynthesis.dustId = 0
CDustSynthesis.num = 0

function CDustSynthesis:Ctor(client)
  CDustSynthesis.super.Ctor(self, client)
end

function CDustSynthesis:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dustId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  return true
end

function CDustSynthesis:Unmarshal(buffer)
  local ret = true
  ret, self.dustId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDustSynthesis
