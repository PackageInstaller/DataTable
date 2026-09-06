local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChangeSubChannel = dataclass("SChangeSubChannel", require("framework.net.protocol"))
SChangeSubChannel.ProtocolType = 1105
SChangeSubChannel.MaxSize = 65535
SChangeSubChannel.num = 0

function SChangeSubChannel:Ctor(client)
  SChangeSubChannel.super.Ctor(self, client)
end

function SChangeSubChannel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  return true
end

function SChangeSubChannel:Unmarshal(buffer)
  local ret = true
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChangeSubChannel
