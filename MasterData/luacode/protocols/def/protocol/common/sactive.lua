local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SActive = dataclass("SActive", require("framework.net.protocol"))
SActive.ProtocolType = 104
SActive.MaxSize = 256
SActive.result = 0

function SActive:Ctor(client)
  SActive.super.Ctor(self, client)
end

function SActive:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SActive:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SActive
