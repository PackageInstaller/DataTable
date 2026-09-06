local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SStartBuffGuide = dataclass("SStartBuffGuide", require("framework.net.protocol"))
SStartBuffGuide.ProtocolType = 2269
SStartBuffGuide.MaxSize = 65535
SStartBuffGuide.buffType = 0

function SStartBuffGuide:Ctor(client)
  SStartBuffGuide.super.Ctor(self, client)
end

function SStartBuffGuide:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.buffType) then
    return false
  end
  return true
end

function SStartBuffGuide:Unmarshal(buffer)
  local ret = true
  ret, self.buffType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SStartBuffGuide
