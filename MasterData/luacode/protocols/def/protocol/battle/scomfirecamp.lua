local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SComfireCamp = dataclass("SComfireCamp", require("framework.net.protocol"))
SComfireCamp.ProtocolType = 4111
SComfireCamp.MaxSize = 65535
SComfireCamp.camp = 0

function SComfireCamp:Ctor(client)
  SComfireCamp.super.Ctor(self, client)
end

function SComfireCamp:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.camp) then
    return false
  end
  return true
end

function SComfireCamp:Unmarshal(buffer)
  local ret = true
  ret, self.camp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SComfireCamp
