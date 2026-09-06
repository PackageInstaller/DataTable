local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CChangeSubChannel = dataclass("CChangeSubChannel", require("framework.net.protocol"))
CChangeSubChannel.ProtocolType = 1104
CChangeSubChannel.MaxSize = 65535
CChangeSubChannel.num = 0
CChangeSubChannel.FLAG_CHANNEL_INEXISTENT = -1
CChangeSubChannel.FLAG_CHANNEL_FULL = -2

function CChangeSubChannel:Ctor(client)
  CChangeSubChannel.super.Ctor(self, client)
end

function CChangeSubChannel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  return true
end

function CChangeSubChannel:Unmarshal(buffer)
  local ret = true
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CChangeSubChannel
